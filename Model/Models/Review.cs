﻿using System;
using System.Collections.Generic;

namespace Model.Models;

public partial class Review
{
    public int ReviewId { get; set; }

    public int TourId { get; set; }

    public int UserId { get; set; }

    public int BookingId { get; set; }

    public int? Rating { get; set; }

    public string? Comment { get; set; }

    public DateOnly ReviewDate { get; set; }

    public virtual Booking Booking { get; set; } = null!;

    public virtual Tour Tour { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
