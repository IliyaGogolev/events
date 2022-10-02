package com.event2go.model.core

data class User(
    val uid: String? = null,
    val name: String? = null,
    val email: String? = null,
    val isEmailVerified: Boolean = false,
    val issuer: String? = null,
    val picture: String? = null
)