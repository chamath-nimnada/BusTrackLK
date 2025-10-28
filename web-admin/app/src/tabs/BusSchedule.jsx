import React, { useEffect, useState } from "react";
import { ClipboardList } from "lucide-react";

const BusSchedule = () => {
  const [bookings, setBookings] = useState([]);

  // Dummy Sri Lankan booking data
  useEffect(() => {
    const dummyBookings = [
      {
        bookingID: "B001",
        date: "2025-10-28",
        customerName: "Nimal Perera",
        startLocation: "Colombo",
        endLocation: "Kandy",
        noOfSeats: 2,
        price: 1500,
      },
      {
        bookingID: "B002",
        date: "2025-10-28",
        customerName: "Kumari Silva",
        startLocation: "Galle",
        endLocation: "Matara",
        noOfSeats: 1,
        price: 450,
      },
      {
        bookingID: "B003",
        date: "2025-10-29",
        customerName: "Saman Jayasinghe",
        startLocation: "Negombo",
        endLocation: "Anuradhapura",
        noOfSeats: 3,
        price: 2000,
      },
      {
        bookingID: "B004",
        date: "2025-10-29",
        customerName: "Dilani Fernando",
        startLocation: "Colombo",
        endLocation: "Jaffna",
        noOfSeats: 1,
        price: 3000,
      },
      {
        bookingID: "B005",
        date: "2025-10-30",
        customerName: "Mahesh de Silva",
        startLocation: "Kandy",
        endLocation: "Nuwara Eliya",
        noOfSeats: 2,
        price: 1200,
      },
      {
        bookingID: "B006",
        date: "2025-10-30",
        customerName: "Shanika Perera",
        startLocation: "Colombo",
        endLocation: "Galle",
        noOfSeats: 1,
        price: 800,
      },
      {
        bookingID: "B007",
        date: "2025-10-31",
        customerName: "Ruwan Silva",
        startLocation: "Matale",
        endLocation: "Kandy",
        noOfSeats: 2,
        price: 700,
      },
      {
        bookingID: "B008",
        date: "2025-10-31",
        customerName: "Chamila Jayawardena",
        startLocation: "Colombo",
        endLocation: "Negombo",
        noOfSeats: 4,
        price: 1200,
      },
      {
        bookingID: "B009",
        date: "2025-11-01",
        customerName: "Priyantha Karunaratne",
        startLocation: "Galle",
        endLocation: "Colombo",
        noOfSeats: 3,
        price: 1100,
      },
      {
        bookingID: "B010",
        date: "2025-11-01",
        customerName: "Sanduni Perera",
        startLocation: "Kandy",
        endLocation: "Colombo",
        noOfSeats: 2,
        price: 900,
      },
    ];

    setBookings(dummyBookings);
  }, []);

  return (
    <div className="container text-light">
      <h3 className="fw-bold mb-4 d-flex align-items-center">
        <ClipboardList size={22} className="me-2" />
        Passenger Bookings
      </h3>

      <div className="table-responsive">
        <table className="table table-dark table-striped table-bordered align-middle">
          <thead>
            <tr>
              <th>Booking ID</th>
              <th>Date</th>
              <th>Customer Name</th>
              <th>Start Location</th>
              <th>End Location</th>
              <th>No. of Seats</th>
              <th>Price (LKR)</th>
            </tr>
          </thead>
          <tbody>
            {bookings.length > 0 ? (
              bookings.map((b) => (
                <tr key={b.bookingID}>
                  <td>{b.bookingID}</td>
                  <td>{b.date}</td>
                  <td>{b.customerName}</td>
                  <td>{b.startLocation}</td>
                  <td>{b.endLocation}</td>
                  <td>{b.noOfSeats}</td>
                  <td>{b.price}</td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="7" className="text-center text-secondary py-4">
                  No bookings found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default BusSchedule;
