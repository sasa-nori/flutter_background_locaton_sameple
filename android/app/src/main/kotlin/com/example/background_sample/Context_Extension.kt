package com.example.background_sample

import android.Manifest
import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import androidx.annotation.RequiresPermission
import androidx.core.content.getSystemService

fun Context.getConnectivityManager(): ConnectivityManager? = getSystemService()

@RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
fun Context.isActiveNetwork(): Boolean {
    return getConnectivityManager()?.let {
        val nw = it.activeNetwork ?: return false
        val actNw = it.getNetworkCapabilities(nw) ?: return false
        return when {
            actNw.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
            actNw.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
            // for other device how are able to connect with Ethernet
            actNw.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> true
            // for check internet over Bluetooth
            actNw.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH) -> true
            else -> false
        }
    } ?: false
}