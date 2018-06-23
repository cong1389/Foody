/**
                             * @version $Id:
                             * @package Digicom.NET
                             * @author Digicom Dev <dev@dgc.vn>
                             * @copyright Copyright (C) 2011 by Digicom. All rights reserved.
                             * @link http://www.dgc.vn
                            */

using System;

namespace Cb.Model
{
    public class PNK_Booking
    {
        #region fields
        private int id;
        private int parentId;
        private int ordering;
        private DateTime postDate;
        private string published;
        private DateTime updateDate;
        private string fullName;
        private string phoneNumber;
        private string email;
        private string requestTour;
        private string expectedDepartureDate;
        private string numberOfAduts;
        private string numberOfChildren;
        private string numberOfInfant;
        private string hotelType;
        private string arrivalPort;
        private string roomType;
        private string roomOther;
        private string bedType;
        private string bedOther;
        private string visaOfNeed;
        private string specialRequest;
        private string travelBefore;
        private string receiveNewsLetters;
        private string knowThrough;
        private string paymentMethod;

        private string distance;
        private string flightArrivalNo;
        private string flightArrivalDate;
        private string flightArrivaTime;
        private string flightDepartureDate;
        private string flightDepartureTime;
        private string customerHeight;
        private string customerAge;
        private string hotelName;
        private string hotelAddress;
        private string country;
        private string city;
        private string pickUpLocation;
        private string address;

        private string firstName;
        private string lastName;
        private string total;
        private string paymentStatus;


        private PNK_BookingDesc bookingDesc;
        #endregion

        #region properties

        public PNK_BookingDesc BookingDesc
        {
            get { return bookingDesc; }
            set { bookingDesc = value; }
        }
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public int ParentId
        {
            get { return this.parentId; }
            set { this.parentId = value; }
        }
        public int Ordering
        {
            get { return this.ordering; }
            set { this.ordering = value; }
        }
        public DateTime PostDate
        {
            get { return this.postDate; }
            set { this.postDate = value; }
        }
        public string Published
        {
            get { return this.published; }
            set { this.published = value; }
        }
        public DateTime UpdateDate
        {
            get { return this.updateDate; }
            set { this.updateDate = value; }
        }

        public string FullName
        {
            get { return this.fullName; }
            set { this.fullName = value; }
        }
        public string PhoneNumber
        {
            get { return this.phoneNumber; }
            set { this.phoneNumber = value; }
        }
        public string Email
        {
            get { return this.email; }
            set { this.email = value; }
        }
        public string RequestTour
        {
            get { return this.requestTour; }
            set { this.requestTour = value; }
        }
        public string ExpectedDepartureDate
        {
            get { return this.expectedDepartureDate; }
            set { this.expectedDepartureDate = value; }
        }
        public string NumberOfAduts
        {
            get { return this.numberOfAduts; }
            set { this.numberOfAduts = value; }
        }
        public string NumberOfChildren
        {
            get { return this.numberOfChildren; }
            set { this.numberOfChildren = value; }
        }

        public string NumberOfInfant
        {
            get { return this.numberOfInfant; }
            set { this.numberOfInfant = value; }
        }
        public string HotelType
        {
            get { return this.hotelType; }
            set { this.hotelType = value; }
        }
        public string ArrivalPort
        {
            get { return this.arrivalPort; }
            set { this.arrivalPort = value; }
        }
        public string RoomType
        {
            get { return this.roomType; }
            set { this.roomType = value; }
        }
        public string RoomOther
        {
            get { return this.roomOther; }
            set { this.roomOther = value; }
        }
        public string BedType
        {
            get { return this.bedType; }
            set { this.bedType = value; }
        }
        public string BedOther
        {
            get { return this.bedOther; }
            set { this.bedOther = value; }
        }
        public string VisaOfNeed
        {
            get { return this.visaOfNeed; }
            set { this.visaOfNeed = value; }
        }
        public string SpecialRequest
        {
            get { return this.specialRequest; }
            set { this.specialRequest = value; }
        }
        public string TravelBefore
        {
            get { return this.travelBefore; }
            set { this.travelBefore = value; }
        }
        public string ReceiveNewsLetters
        {
            get { return this.receiveNewsLetters; }
            set { this.receiveNewsLetters = value; }
        }
        public string KnowThrough
        {
            get { return this.knowThrough; }
            set { this.knowThrough = value; }
        }
        public string PaymentMethod
        {
            get { return this.paymentMethod; }
            set { this.paymentMethod = value; }
        }

        public string Distance
        {
            get { return this.distance; }
            set { this.distance = value; }
        }

        public string FlightArrivalNo
        {
            get { return this.flightArrivalNo; }
            set { this.flightArrivalNo = value; }
        }
        public string FlightArrivalDate
        {
            get { return this.flightArrivalDate; }
            set { this.flightArrivalDate = value; }
        }
        public string FlightArrivaTime
        {
            get { return this.flightArrivaTime; }
            set { this.flightArrivaTime = value; }
        }
        public string FlightDepartureDate
        {
            get { return this.flightDepartureDate; }
            set { this.flightDepartureDate = value; }
        }
        public string FlightDepartureTime
        {
            get { return this.flightDepartureTime; }
            set { this.flightDepartureTime = value; }
        }
        public string CustomerHeight
        {
            get { return this.customerHeight; }
            set { this.customerHeight = value; }
        }
        public string CustomerAge
        {
            get { return this.customerAge; }
            set { this.customerAge = value; }
        }
        public string HotelName
        {
            get { return this.hotelName; }
            set { this.hotelName = value; }
        }
        public string HotelAddress
        {
            get { return this.hotelAddress; }
            set { this.hotelAddress = value; }
        }
        public string Country
        {
            get { return this.country; }
            set { this.country = value; }
        }
        public string City
        {
            get { return this.city; }
            set { this.city = value; }
        }
        public string PickUpLocation
        {
            get { return this.pickUpLocation; }
            set { this.pickUpLocation = value; }
        }
        public string Address
        {
            get { return this.address; }
            set { this.address = value; }
        }

        public string FirstName
        {
            get { return this.firstName; }
            set { this.firstName = value; }
        }
        public string LastName
        {
            get { return this.lastName; }
            set { this.lastName = value; }
        }
        public string Total
        {
            get { return this.total; }
            set { this.total = value; }
        }
        public string PaymentStatus
        {
            get { return this.paymentStatus; }
            set { this.paymentStatus = value; }
        }

        #endregion

        #region constructor
        public PNK_Booking()
        {
            this.id = int.MinValue;
            this.parentId = int.MinValue;
            this.ordering = int.MinValue;
            this.postDate = DateTime.MinValue;
            this.published = string.Empty;
            this.updateDate = DateTime.MinValue;
            this.fullName = string.Empty;
            this.phoneNumber = string.Empty;
            this.email = string.Empty;
            this.requestTour = string.Empty;
            this.expectedDepartureDate = string.Empty;
            this.numberOfAduts = string.Empty;
            this.numberOfChildren = string.Empty;
            this.numberOfInfant = string.Empty;
            this.hotelType = string.Empty;
            this.arrivalPort = string.Empty;
            this.roomType = string.Empty;
            this.roomOther = string.Empty;
            this.bedType = string.Empty;
            this.bedOther = string.Empty;
            this.visaOfNeed = string.Empty;
            this.specialRequest = string.Empty;
            this.travelBefore = string.Empty;
            this.receiveNewsLetters = string.Empty;
            this.knowThrough = string.Empty;
            this.paymentMethod = string.Empty;
            this.distance = string.Empty;
            this.flightArrivalNo = string.Empty;
            this.flightArrivalDate = string.Empty;
            this.flightArrivaTime = string.Empty;
            this.flightDepartureDate = string.Empty;
            this.flightDepartureTime = string.Empty;
            this.customerHeight = string.Empty;
            this.customerAge = string.Empty;
            this.hotelName = string.Empty;
            this.hotelAddress = string.Empty;
            this.country = string.Empty;
            this.city = string.Empty;
            this.pickUpLocation = string.Empty;
            this.address = string.Empty;

            this.firstName = string.Empty;
            this.lastName = string.Empty;
            this.total = string.Empty;
            this.paymentStatus = string.Empty;

            bookingDesc = new PNK_BookingDesc();
        }
        public PNK_Booking(int id,
                    int parentId,
                    int ordering,
                    DateTime postDate,
                    string published,
                    DateTime updateDate,
                    string fullName,
                    string phoneNumber,
                    string email,
                    string requestTour,
                    string expectedDepartureDate,
                    string numberOfAduts,
                    string numberOfChildren,
                    string numberOfInfant,
                    string hotelType,
                    string arrivalPort,
                    string roomType,
                    string roomOther,
                    string bedType,
                    string bedOther,
                    string visaOfNeed,
                    string specialRequest,
                    string travelBefore,
                    string receiveNewsLetters,
                    string knowThrough,
                    string paymentMethod
                    , string distance,
                    string flightArrivalNo,
                    string flightArrivalDate,
                    string flightArrivaTime,
                    string flightDepartureDate,
                    string flightDepartureTime,
                    string customerHeight,
                    string customerAge,
                    string hotelName,
                    string hotelAddress,
                    string country,
                    string city,
                    string pickUpLocation,
                    string address,
                    string firstName,
                    string lastName,
                    string total,
                    string paymentStatus)
        {
            this.id = id;
            this.parentId = parentId;
            this.ordering = ordering;
            this.postDate = postDate;
            this.published = published;
            this.updateDate = updateDate;
            this.fullName = fullName;
            this.phoneNumber = phoneNumber;
            this.email = email;
            this.requestTour = requestTour;
            this.expectedDepartureDate = expectedDepartureDate;
            this.numberOfAduts = numberOfAduts;
            this.numberOfChildren = numberOfChildren;
            this.numberOfInfant = numberOfInfant;
            this.hotelType = hotelType;
            this.arrivalPort = arrivalPort;
            this.roomType = roomType;
            this.roomOther = roomOther;
            this.bedType = bedType;
            this.bedOther = bedOther;
            this.visaOfNeed = visaOfNeed;
            this.specialRequest = specialRequest;
            this.travelBefore = travelBefore;
            this.receiveNewsLetters = receiveNewsLetters;
            this.knowThrough = knowThrough;
            this.paymentMethod = paymentMethod;
            this.paymentMethod = paymentMethod;
            this.distance = distance;
            this.flightArrivalNo = flightArrivalNo;
            this.flightArrivalDate = flightArrivalDate;
            this.flightArrivaTime = flightArrivaTime;
            this.flightDepartureDate = flightDepartureDate;
            this.flightDepartureTime = flightDepartureTime;
            this.customerHeight = customerHeight;
            this.customerAge = customerAge;
            this.hotelName = hotelName;
            this.hotelAddress = hotelAddress;
            this.country = country;
            this.city = city;
            this.pickUpLocation = pickUpLocation;
            this.address = address;
            this.firstName = firstName;
            this.lastName = lastName;
            this.total = total;
            this.paymentStatus = paymentStatus;
        }
        #endregion

    }
}