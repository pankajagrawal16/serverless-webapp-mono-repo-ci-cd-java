package org.example

import com.microsoft.azure.functions.*
import com.microsoft.azure.functions.annotation.*
import java.util.*

class FileUploadProcessorFunction {

    @FunctionName("file-upload-processor")
    fun run(
        @BlobTrigger(
            name = "content",
            dataType = "binary",
            path = "images/{fileName}",
            source = "EventGrid",
            connection = "TRIGGER_CONNECTION_serviceUri"
        ) content: ByteArray,
        @BindingName("fileName") fileName: String,
        context: ExecutionContext
    ) {
        context.logger.info("Name: $fileName  Size: ${content.size} bytes");
    }
}
