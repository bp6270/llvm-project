; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686--   -mattr=+slow-3ops-lea | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=i686--   -mattr=-slow-3ops-lea | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-- -mattr=+slow-3ops-lea | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mattr=-slow-3ops-lea | FileCheck %s --check-prefix=X64

; )32-a)-b  -->  32-(a+b)  -->  -(a+b)+32  -->  -((a+b)-32)  ->  -(a+b+(-32))

define i32 @t0(i32 %a, i32 %b) {
; X86-LABEL: t0:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $32, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t0:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %edi
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %t0 = sub i32 32, %a
  %r = sub i32 %t0, %b
  ret i32 %r
}
define i32 @t1(i32 %a, i32 %b) {
; X86-LABEL: t1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $32, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %edi
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %t0 = add i32 %a, %b
  %r = sub i32 32, %t0
  ret i32 %r
}
define i32 @t2(i32 %a, i32 %b) {
; X86-LABEL: t2:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $32, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t2:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %edi
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %t0 = add i32 %a, %b
  %t1 = sub i32 0, %t0
  %r = add i32 %t1, 32
  ret i32 %r
}
define i32 @t3(i32 %a, i32 %b) {
; X86-LABEL: t3:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl $32, %eax
; X86-NEXT:    subl %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: t3:
; X64:       # %bb.0:
; X64-NEXT:    addl %esi, %edi
; X64-NEXT:    movl $32, %eax
; X64-NEXT:    subl %edi, %eax
; X64-NEXT:    retq
  %t0 = add i32 %a, %b
  %t1 = sub i32 %t0, 32
  %r = sub i32 0, %t1
  ret i32 %r
}
