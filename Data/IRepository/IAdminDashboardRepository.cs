﻿using Model.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.IRepository
{
    public interface IAdminDashboardRepository
    {
        DashboardDto GetDashboardData();
    }
}
