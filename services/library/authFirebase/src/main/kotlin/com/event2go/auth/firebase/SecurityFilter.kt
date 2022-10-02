package com.event2go.auth.firebase

import com.event2go.model.auth.UserAuthenticationToken
import com.event2go.model.core.User
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseAuthException
import com.google.firebase.auth.FirebaseToken
import org.apache.logging.log4j.LogManager
import org.apache.logging.log4j.Logger
import org.springframework.boot.web.servlet.FilterRegistrationBean
import org.springframework.context.annotation.Bean
import org.springframework.core.Ordered
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter
import java.io.IOException
import javax.servlet.FilterChain
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse


private val log: Logger = LogManager.getLogger()

@Component
class SecurityFilter : OncePerRequestFilter() {
    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        verifyToken(request)
        filterChain.doFilter(request, response)
    }

}

private fun FirebaseToken?.toUser(): User? =
    this?.let {
        User(
            uid = uid,
            name = name,
            email = email,
            picture = picture,
            issuer = issuer,
            isEmailVerified = isEmailVerified
        )
    }

@Bean
fun firabaseTokenFilter(): FilterRegistrationBean<OncePerRequestFilter>? {
    val filter: OncePerRequestFilter = object : OncePerRequestFilter() {

        @Throws(ServletException::class, IOException::class)
        override fun doFilterInternal(
            request: HttpServletRequest, response: HttpServletResponse,
            filterChain: FilterChain
        ) {
            verifyToken(request)
            filterChain.doFilter(request, response)
        }
    }
    val bean = FilterRegistrationBean(filter)
    bean.order = Ordered.HIGHEST_PRECEDENCE
    return bean
}

fun getBearerToken(request: HttpServletRequest): String? {
    val authorization = request.getHeader("Authorization")
    return authorization?.takeIf { it.isNotEmpty() && it.startsWith("Bearer ") }?.let {
        it.substring(7, authorization.length)
    }
}

private fun verifyToken(request: HttpServletRequest) {

    val isEnableCheckSessionRevoked = false
    var session: String? = null
    var decodedToken: FirebaseToken? = null
//    val strictServerSessionEnabled: Boolean = securityProps.getFirebaseProps().isEnableStrictServerSession()
    val token: String? = getBearerToken(request)
    log.info("token: $token")
    try {

//        val user = FirebaseAuth.getInstance().getUser("GAPrZW9tmRVjikU5KuWAtyEeEWF3");
//        user.getIdToken
//        if (sessionCookie != null) {
//            session = sessionCookie.value
//            decodedToken = FirebaseAuth.getInstance().verifySessionCookie(
//                session,
//                isEnableCheckSessionRevoked
//            )
//            type = Credentials.CredentialType.SESSION
//        } else if (!strictServerSessionEnabled) {
        if (token != null && !token.equals("undefined", ignoreCase = true)) {

//            val authentication = UserAuthenticationToken(
//                user = null,
//                token = token,
//                authorities = null
//            )
//            SecurityContextHolder.getContext().authentication = authentication

            decodedToken = FirebaseAuth.getInstance().verifyIdToken(token)
            log.info("decodedToken: $decodedToken")
            val user: User? = decodedToken.toUser()
            log.info("user: $user")
            if (user != null) {
                val authentication = UserAuthenticationToken(
                    user = user,
                    token = token,
                    authorities = null
                )
                SecurityContextHolder.getContext().authentication = authentication
            }
        }
    } catch (e: FirebaseAuthException) {
        log.error("Firebase Exception:: ${e.message}")
        e.printStackTrace()
    } catch (e: IllegalArgumentException) {
        log.info("IllegalArgumentException :: ${e.localizedMessage}")
    }
}
