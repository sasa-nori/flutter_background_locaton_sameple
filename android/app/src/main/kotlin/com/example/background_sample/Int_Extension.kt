package com.example.background_sample

import java.util.Calendar
import java.util.Date
import java.util.Locale

fun Int.toDatePlusMinute(): Date {
    val now = Calendar.getInstance(Locale.JAPAN).apply {
        clear(Calendar.SECOND)
    }
    now.add(Calendar.MINUTE, this)
    return now.time
}