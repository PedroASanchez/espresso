#
# Copyright (C) 2013-2019 The ESPResSo project
#
# This file is part of ESPResSo.
#
# ESPResSo is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ESPResSo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
from libcpp cimport bool as cbool
from libc cimport stdint

include "myconfig.pxi"
from .utils cimport Vector3d

cdef extern from "thermostat.hpp":
    double temperature
    int thermo_switch
    cbool thermo_virtual
    int THERMO_OFF
    int THERMO_LANGEVIN
    int THERMO_LB
    int THERMO_NPT_ISO
    int THERMO_DPD

    IF PARTICLE_ANISOTROPY:
        Vector3d langevin_gamma_rotation
        Vector3d langevin_gamma
    ELSE:
        double langevin_gamma_rotation
        double langevin_gamma

    void langevin_set_rng_state(stdint.uint64_t counter)
    cbool langevin_is_seed_required()

    stdint.uint64_t langevin_get_rng_state()

cdef extern from "dpd.hpp":
    IF DPD:
        void dpd_set_rng_state(stdint.uint64_t counter)
        cbool dpd_is_seed_required()
        stdint.uint64_t dpd_get_rng_state()
