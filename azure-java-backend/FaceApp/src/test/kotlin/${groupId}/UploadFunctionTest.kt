package org.example

import com.microsoft.azure.functions.*
import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.Test
import org.mockito.ArgumentMatchers.any
import org.mockito.Mockito.*
import java.util.*
import java.util.logging.Logger

class UploadFunctionTest {

    inline fun <reified T : Any> mock() = mock(T::class.java)

    private fun testHttpTrigger(httpMethod: HttpMethod) {
        // Setup
        val req = mock<HttpRequestMessage<Optional<String>>>()

        val queryParams = HashMap<String, String>()
        queryParams["name"] = "Azure"
        doReturn(queryParams).`when`(req).queryParameters

        val queryBody = Optional.empty<String>()
        doReturn(queryBody).`when`<HttpRequestMessage<*>>(req).body
        doReturn(httpMethod).`when`<HttpRequestMessage<*>>(req).httpMethod

        doAnswer { invocation ->
            val status = invocation.arguments[0] as HttpStatus
            HttpResponseMessageMock.HttpResponseMessageBuilderMock().status(status)
        }.`when`<HttpRequestMessage<*>>(req).createResponseBuilder(any(HttpStatus::class.java))

        val context = mock(ExecutionContext::class.java)
        doReturn(Logger.getGlobal()).`when`(context).logger

        // Invoke
        val ret = UploadFunction().run(req, context)

        // Verify
        assertEquals(ret.status, HttpStatus.OK)
    }

    @Test
    @Throws(Exception::class)
    fun testHttpTriggerGET() {
        testHttpTrigger(HttpMethod.GET)
    }

    @Test
    @Throws(Exception::class)
    fun testHttpTriggerPOST() {
        testHttpTrigger(HttpMethod.POST)
    }

}
