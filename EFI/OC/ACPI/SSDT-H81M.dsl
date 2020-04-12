DefinitionBlock ("", "SSDT", 2, "ACDT", "H81M", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_PR_.CPU0, ProcessorObj)
    If (_OSI ("Darwin"))
    {
        Scope (_SB)
        {
            Device (USBX)
            {
                Name (_ADR, Zero)
                Method (_DSM, 4, NotSerialized)
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                            0x03
                        })
                    }
                    Return (Package ()
                    {
                        "kUSBSleepPortCurrentLimit",
                        0x0960,
                        "kUSBWakePortCurrentLimit",
                        0x0960
                    })
                }
            }
        }
        Scope (_SB.PCI0)
        {
            Device (MCHC)
            {
                Name (_ADR, Zero)
            }
        }
        Scope (_SB.PCI0.LPCB)
        {
            Device (EC)
            {
                Name (_HID, "ACID0001")
            }
        }
        Scope (_SB.PCI0.SBUS)
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
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        Return (Package ()
                        {
                            "address", 
                            0x57
                        })
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
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                            0x03
                        })
                    }
                    Return (Package ()
                    {
                        "plugin-type", 
                        One
                    })
                }
            }
        }
    }
}