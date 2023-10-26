
SECTIONS
{
    
    . = 0x7C00;

    .text :
    {
        *(.text)
    }

    /DISCARD/ :
    {
        *(__CTOR_LIST__*)
        *(__DTOR_LIST__*)
        *(.comment)
    }

}
