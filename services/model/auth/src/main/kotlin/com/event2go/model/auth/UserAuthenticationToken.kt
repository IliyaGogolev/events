package com.event2go.model.auth

import com.event2go.model.core.User
import org.springframework.security.authentication.AbstractAuthenticationToken
import org.springframework.security.core.GrantedAuthority

class UserAuthenticationToken (
    val user: User?,
    val token: String?,
    authorities: MutableCollection<out GrantedAuthority>? = null,
): AbstractAuthenticationToken(authorities) {

    override fun getCredentials(): Any? = null
    override fun getPrincipal(): Any? = null

}