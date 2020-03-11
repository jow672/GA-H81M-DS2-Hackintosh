DefinitionBlock ("", "SSDT", 2, "ACDT", "H81M", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_PR_.CPU0, ProcessorObj)
    If (_OSI ("Darwin"))
    {
        Method (DTGP, 5, NotSerialized)
        {
            If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
            {
                If ((Arg1 == One))
                {
                    If ((Arg2 == Zero))
                    {
                        Arg4 = Buffer (One)
                            {
                                0x03
                            }
                        Return (One)
                    }
                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
            }
            Arg4 = Buffer (One)
                {
                    0x00
                }
            Return (Zero)
        }
        Scope (_SB)
        {
            Device (USBX)
            {
                Name (_ADR, Zero)
                Method (_DSM, 4, NotSerialized)
                {
                    Local0 = Package ()
                        {
                            "kUSBSleepPortCurrentLimit",
                            0x0960,
                            "kUSBWakePortCurrentLimit",
                            0x0960
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
            Scope (PCI0)
            {
                Device (MCHC)
                {
                    Name (_ADR, Zero)
                }
                Scope (LPCB)
                {
                    Device (EC)
                    {
                        Name (_HID, "ACID0001")
                    }
                }
                Scope (SBUS)
                {
                    Device (BUS0)
                    {
                        Name (_CID, "smbus")
                        Name (_ADR, Zero)
                        Device (DVL0)
                        {
                            Name (_ADR, 0x57)
                            Name (_CID, "diagsvault")
                            Method (_DSM, 4, NotSerialized)
                            {
                                Local0 = Package ()
                                    {
                                        "address", 
                                        0x57
                                    }
                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }
                    }
                }
            }
        }
        Scope (_PR)
        {
            Scope (CPU0)
            {
                Method (_DSM, 4, NotSerialized)
                {
                    Local0 = Package ()
                        {
                            "plugin-type", 
                            One
                        }
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }
            }
        }
    } 
}      