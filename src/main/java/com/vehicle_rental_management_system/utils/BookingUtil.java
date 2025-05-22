package com.vehicle_rental_management_system.utils;

import com.vehicle_rental_management_system.models.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookingUtil {
    private static final String FILE_PATH = "C:\\Users\\NIHINDU LONETH\\IdeaProjects\\vehicle-rental-management-system\\vehicle-rental-management-system\\src\\main\\webapp\\WEB-INF\\data\\bookings.txt";

    private static int lastId = 0;

    static {
        initializeLastId();
    }

    private static void initializeLastId() {
        List<Booking> bookings = readBookings();
        lastId = bookings.stream()
                .mapToInt(Booking::getBookingId)
                .max()
                .orElse(0);
    }

    public static List<Booking> readBookings() {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating bookings file: " + e.getMessage());
            }
            return bookings;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    try {
                        int id = Integer.parseInt(parts[0].trim());
                        long startDateMillis = parts[3].trim().isEmpty() ? 0 : Long.parseLong(parts[3].trim());
                        long endDateMillis = parts[4].trim().isEmpty() ? 0 : Long.parseLong(parts[4].trim());

                        bookings.add(new Booking(
                                id,
                                parts[1].trim(),
                                parts[2].trim(),
                                startDateMillis > 0 ? new Date(startDateMillis) : null,
                                endDateMillis > 0 ? new Date(endDateMillis) : null,
                                parts[5].trim().isEmpty() ? 0.0 : Double.parseDouble(parts[5].trim()),
                                parts[6].trim()
                        ));
                    } catch (NumberFormatException e) {
                        System.err.println("Skipping malformed booking line: " + line);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading bookings file: " + e.getMessage());
        }
        return bookings;
    }

    public static void writeBookings(List<Booking> bookings) {
        File file = new File(FILE_PATH);
        try {
            // Ensure directory exists
            file.getParentFile().mkdirs();

            // Verify we can write
            if (!file.exists()) {
                System.out.println("Creating new file at: " + file.getAbsolutePath());
                file.createNewFile();
            }

            // Write with UTF-8 encoding
            try (BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(new FileOutputStream(file), "UTF-8"))) {

                for (Booking booking : bookings) {
                    writer.write(booking.toString());
                    writer.newLine();
                }
                System.out.println("Successfully wrote " + bookings.size() + " records");
            }
        } catch (IOException e) {
            System.err.println("FILE WRITE FAILED!");
            e.printStackTrace();
            throw new RuntimeException("Failed to save bookings", e);
        }
    }

    public static Booking findBookingById(int bookingId) {
        return readBookings().stream()
                .filter(booking -> booking.getBookingId() == bookingId)
                .findFirst()
                .orElse(null);
    }

    public static boolean addBooking(Booking newBooking) {
        System.out.println("=== Starting addBooking ===");
        System.out.println("File location: " + FILE_PATH);

        try {
            List<Booking> bookings = readBookings();
            System.out.println("Current bookings count: " + bookings.size());

            newBooking.setBookingId(++lastId);
            bookings.add(newBooking);

            System.out.println("Attempting to write " + bookings.size() + " bookings");
            writeBookings(bookings);

            System.out.println("=== Booking successfully added ===");
            return true;
        } catch (Exception e) {
            System.err.println("!!! CRITICAL ERROR !!!");
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateBooking(Booking updatedBooking) {
        List<Booking> bookings = readBookings();
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getBookingId() == updatedBooking.getBookingId()) {
                bookings.set(i, updatedBooking);
                writeBookings(bookings);
                return true;
            }
        }
        return false;
    }

    public static boolean deleteBooking(int bookingId) {
        List<Booking> bookings = readBookings();
        boolean removed = bookings.removeIf(booking -> booking.getBookingId() == bookingId);
        if (removed) {
            writeBookings(bookings);
        }
        return removed;
    }

    public static boolean cancelBooking(int bookingId) {
        Booking booking = findBookingById(bookingId);
        if (booking != null) {
            booking.setStatus("cancelled");
            return updateBooking(booking);
        }
        return false;
    }

    public static boolean completeBooking(int bookingId) {
        Booking booking = findBookingById(bookingId);
        if (booking != null) {
            booking.setStatus("completed");
            return updateBooking(booking);
        }
        return false;
    }
}