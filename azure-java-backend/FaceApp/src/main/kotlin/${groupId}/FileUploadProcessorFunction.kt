package org.example

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.microsoft.azure.functions.*
import com.microsoft.azure.functions.annotation.*
import java.util.*

class FileUploadProcessorFunction {
    private val mapper = jacksonObjectMapper()

    @FunctionName("file-upload-processor")
    @CosmosDBOutput(name =  "database",
        databaseName = "faceapp",
        collectionName = "faces",
        connectionStringSetting = "FaceAppDatabaseConnectionString"
        )
    fun run(
        @BlobTrigger(
            name = "content",
            dataType = "binary",
            path = "images/{fileName}",
            source = "EventGrid",
            connection = "FaceStorage"
        ) content: ByteArray,
        @BindingName("fileName") fileName: String,
        context: ExecutionContext
    ): String {
        context.logger.info("Name: $fileName  Size: ${content.size} bytes")
        return mapper.writeValueAsString(FaceRegistration(UUID.randomUUID().toString(),fileName))
    }

    data class FaceRegistration(val id: String, val name: String)
}
