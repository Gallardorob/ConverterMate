class Units {
  static List<String> getMeasurements() {
    return <String>[
      "acceleration",
      "angle",
      "apparentPower",
      "area",
      "charge",
      "current",
      "digital",
      "each",
      "energy",
      "force",
      "frequency",
      "illuminance",
      "length",
      "mass",
      "massFlowRate",
      "pace",
      "partsPer",
      "pieces",
      "power",
      "pressure",
      "reactiveEnergy",
      "reactivePower",
      "speed",
      "temperature",
      "time",
      "voltage",
      "volume",
      "volumeFlowRate"
    ];
  }

  static List<String> getUnits(String measure) {
    List<String> unitsList;
    if (measure == "acceleration") {
      // 2
      unitsList = <String>["g-force", "m/s2"];
    }

    if (measure == "angle") {
      // 5
      unitsList = <String>["rad", "deg", "grad", "arcmin", "arcsec"];
    }

    if (measure == "apparentPower") {
      // 5
      unitsList = <String>["VA", "mVA", "kVA", "MVA", "GVA"];
    }

    if (measure == "area") {
      // 12
      unitsList = <String>[
        "nm2",
        "μm2",
        "mm2",
        "cm2",
        "m2",
        "ha",
        "km2",
        "in2",
        "yd2",
        "ft2",
        "ac",
        "mi2"
      ];
    }

    if (measure == "charge") {
      // 5
      unitsList = <String>["c", "mC", "μC", "nC", "pC"];
    }

    if (measure == "current") {
      // 3
      unitsList = <String>["A", "mA", "kA"];
    }

    if (measure == "digital") {
      // 10
      unitsList = <String>[
        "b",
        "Kb",
        "Mb",
        "Gb",
        "Tb",
        "B",
        "KB",
        "MB",
        "GB",
        "TB"
      ];
    }

    if (measure == "each") {
      // 2
      unitsList = <String>["ea", "dz"];
    }

    if (measure == "energy") {
      // 9
      unitsList = <String>[
        "Wh",
        "mWh",
        "kWh",
        "MWh",
        "GWh",
        "J",
        "kJ",
        "MJ",
        "GJ"
      ];
    }

    if (measure == "force") {
      // 3
      unitsList = <String>["N", "kN", "lbf"];
    }

    if (measure == "frequency") {
      // 9
      unitsList = <String>[
        "mHz",
        "Hz",
        "kHz",
        "MHz",
        "GHz",
        "THz",
        "rpm",
        "deg/s",
        "rad/s"
      ];
    }

    if (measure == "illuminance") {
      // 2
      unitsList = <String>["lx", "ft-cd"];
    }

    if (measure == "length") {
      // 13
      unitsList = <String>[
        "nm",
        "μm",
        "mm",
        "cm",
        "m",
        "km",
        "in",
        "yd",
        "ft-us",
        "ft",
        "fathom",
        "mi",
        "nMi"
      ];
    }

    if (measure == "massFlowRate") {
      // 5
      unitsList = <String>["kg/s", "kg/h", "mt/h", "lb/s", "lb/h"];
    }

    if (measure == "mass") {
      // 8
      unitsList = <String>["mcg", "mg", "g", "kg", "mt", "oz", "lb", "t"];
    }

    if (measure == "pace") {
      // 4
      unitsList = <String>["min/km", "s/m", "min/mi", "s/ft"];
    }

    if (measure == "partsPer") {
      // 4
      unitsList = <String>["ppm", "ppb", "ppt", "ppq"];
    }

    if (measure == "pieces") {
      // 13
      unitsList = <String>[
        "pcs",
        "bk-doz",
        "cp",
        "doz-doz",
        "doz",
        "gr-gr",
        "gros",
        "half-dozen",
        "long-hundred",
        "ream",
        "scores",
        "sm-gr",
        "trio"
      ];
    }

    if (measure == "power") {
      // 10
      unitsList = <String>[
        "W",
        "mW",
        "kW",
        "MW",
        "GW",
        "PS",
        "Btu/s",
        "ft-lb/s",
        "hp"
      ];
    }

    if (measure == "pressure") {
      // 10
      unitsList = <String>[
        "Pa",
        "kPa",
        "MPa",
        "hPa",
        "bar",
        "torr",
        "psi",
        "ksi",
        "inHg",
      ];
    }

    if (measure == "reactiveEnergy") {
      // 5
      unitsList = <String>["VARh", "mVARh", "kVARh", "MVARh", "GVARh"];
    }

    if (measure == "reactivePower") {
      // 5
      unitsList = <String>["VAR", "mVAR", "kVAR", "MVAR", "GVAR"];
    }

    if (measure == "speed") {
      // 8
      unitsList = <String>[
        "m/s",
        "km/h",
        "mm/h",
        "mph",
        "knot",
        "ft/s",
        "ft/min",
        "in/h"
      ];
    }

    if (measure == "temperature") {
      // 4
      unitsList = <String>["C", "K", "F", "R"];
    }

    if (measure == "time") {
      // 11
      unitsList = <String>[
        "ns",
        "mu",
        "ms",
        "s",
        "min",
        "h",
        "d",
        "week",
        "month",
        "year"
      ];
    }

    if (measure == "voltage") {
      // 3
      unitsList = <String>["V", "mV", "kV"];
    }

    if (measure == "volume") {
      // 27
      unitsList = <String>[
        "mm3",
        "cm3",
        "ml",
        "cl",
        "dl",
        "l",
        "kl",
        "Ml",
        "Gl",
        "m3",
        "km3",
        "krm",
        "tsk",
        "msk",
        "kkp",
        "glas",
        "kanna",
        "tsp",
        "Tbs",
        "in3",
        "fl-oz",
        "cup",
        "pnt",
        "qt",
        "gal",
        "ft3",
        "yd3"
      ];
    }

    if (measure == "volumeFlowRate") {
      // 37
      unitsList = <String>[
        "mm3/s",
        "cm3/s",
        "ml/s",
        "cl/s",
        "dl/s",
        "l/s",
        "l/min",
        "l/h",
        "kl/s",
        "kl/min",
        "kl/h",
        "m3/s",
        "m3/min",
        "m3/h",
        "km3/s",
        "tsp/s",
        "Tbs/s",
        "in3/s",
        "in3/min",
        "in3/h",
        "fl-oz/s",
        "fl-oz/min",
        "fl-oz/h",
        "cup/s",
        "pnt/s",
        "pnt/min",
        "pnt/h",
        "qt/s",
        "gal/s",
        "gal/min",
        "gal/h",
        "ft3/s",
        "ft3/min",
        "ft3/h",
        "yd3/s",
        "yd3/min",
        "yd3/h"
      ];
    }

    return unitsList;
  }
}
