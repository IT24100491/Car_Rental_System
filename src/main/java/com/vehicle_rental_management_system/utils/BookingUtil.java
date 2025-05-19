package com.vehicle_rental_management_system.utils;

import com.vehicle_rental_management_system.model.Booking;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookingUtil {
    private static List<Booking> bookings = new ArrayList<>();
    private static int nextId = 1;

    static {
        // Initialize with some sample data
        bookings.add(new Booking("R001", "V001", "C001",
                LocalDateTime.now().minusDays(2), LocalDateTime.now().plusDays(3),
                "active", 150.0, true, false));
        bookings.add(new Booking("R002", "V002", "C002",
                LocalDateTime.now().minusDays(5), LocalDateTime.now().minusDays(1),
                "completed", 200.0, false, true));
    }

    public List<Booking> readBookings() {
        return new ArrayList<>(bookings);
    }

    public Booking findBookingById(String bookingId) {
        return bookings.stream()
                .filter(b -> b.getBookingId().equals(bookingId))
                .findFirst()
                .orElse(null);
    }

    public boolean addBooking(Booking booking) {
        booking.setBookingId("R" + String.format("%03d", nextId++));
        return bookings.add(booking);
    }

    public boolean updateBooking(Booking updatedBooking) {
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getBookingId().equals(updatedBooking.getBookingId())) {
                bookings.set(i, updatedBooking);
                return true;
            }
        }
        return false;
    }

    public boolean cancelBooking(String bookingId) {
        Booking booking = findBookingById(bookingId);
        if (booking != null && booking.getStatus().equals("active")) {
            booking.setStatus("cancelled");
            return true;
        }
        return false;
    }

    public boolean processReturn(String bookingId) {
        Booking booking = findBookingById(bookingId);
        if (booking != null && booking.getStatus().equals("active")) {
            booking.setStatus("completed");
            booking.setEndTime(LocalDateTime.now());
            return true;
        }
        return false;
    }
}//test