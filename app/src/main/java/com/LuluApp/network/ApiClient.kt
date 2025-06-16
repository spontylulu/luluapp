// ApiClient.kt
package com.luluapp.network

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.Body
import retrofit2.http.Headers
import retrofit2.http.POST

// URL pubblico del server Lulu
const val BASE_URL = "https://lulu-server.onrender.com"

// Dati della richiesta
data class AIRequest(
    val message: String
)

// Dati della risposta
data class AIResponse(
    val reply: String
)

// Interfaccia Retrofit per l'API
interface LuluApiService {
    @Headers("Content-Type: application/json")
    @POST("/api/ai")
    suspend fun sendMessage(@Body request: AIRequest): AIResponse
}

// Singleton che gestisce la connessione
object ApiClient {
    val api: LuluApiService by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(LuluApiService::class.java)
    }
}
