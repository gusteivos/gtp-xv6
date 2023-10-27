#include "boot.efi.h"

EFI_SYSTEM_TABLE *GLOBAL_SystemTable;

void efi_hard_reboot()
{
    // Hardware Reboot
    GLOBAL_SystemTable->RuntimeServices->ResetSystem(EfiResetCold, EFI_SUCCESS, 0, 0);
}

void efi_soft_reboot()
{
    // Software reboot
    GLOBAL_SystemTable->RuntimeServices->ResetSystem(EfiResetWarm, EFI_SUCCESS, 0, 0);
}

void efi_shutdown()
{
    // Shuts off the computer
    GLOBAL_SystemTable->RuntimeServices->ResetSystem(EfiResetShutdown, EFI_SUCCESS, 0, 0);
}

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{


    efi_shutdown();

    return 0;

}
