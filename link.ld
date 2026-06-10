MEMORY
{
  /* STM32F100RB: 128KB Flash, 8KB RAM */
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 128K
  RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

ENTRY(start_here);

SECTIONS
{
  .vector_table :
  {
    LONG(ORIGIN(RAM) + LENGTH(RAM)); /* Initial Stack Pointer */
    LONG(start_here | 1);            /* Reset Vector. The "| 1" is required due to Thumb instruction stuff */
  } > FLASH

  .text :
  {
    *(.text .text.*);
  } > FLASH
}