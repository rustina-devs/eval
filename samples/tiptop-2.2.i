# 26 "/usr/include/asm-generic/int-ll64.h"
typedef unsigned int __u32;

# 30 "/usr/include/asm-generic/int-ll64.h"
typedef unsigned long long __u64;

# 7 "/usr/include/i386-linux-gnu/asm/swab.h"
static __inline__ __u32 __arch_swab32(__u32 val)
{
 __asm__("bswapl %0" : "=r" (val) : "0" (val));
 return val;
}

# 14 "/usr/include/i386-linux-gnu/asm/swab.h"
static __inline__ __u64 __arch_swab64(__u64 val)
{

 union {
  struct {
   __u32 a;
   __u32 b;
  } s;
  __u64 u;
 } v;
 v.u = val;
 __asm__("bswapl %0 ; bswapl %1 ; xchgl %0,%1"
     : "=r" (v.s.a), "=r" (v.s.b)
     : "0" (v.s.a), "1" (v.s.b));
 return v.u;




}

# 49 "target-x86.c"
static int disp_family_model()
{
  int a;
  int disp_model, disp_family;

  asm("mov $1, %%eax; " /* a into eax */
      "cpuid;"
      "mov %%eax, %0;" /* eax into a */
      :"=r"(a) /* output */
      :
      :"%eax","%ebx","%ecx","%edx" /* clobbered register */
     );
  disp_model = ((a >> 4) & 0xf) | (((a >> 16) & 0xf) << 4);
  disp_family = ((a >> 8) & 0xf) | (((a >> 20) & 0xff) << 4);
  return (disp_family << 8) | disp_model;
}

