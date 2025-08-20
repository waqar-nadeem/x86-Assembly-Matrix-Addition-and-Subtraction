INCLUDE Irvine32.inc

.data
promptOp BYTE "Enter 1 for Addition or 2 for Subtraction: ",0
promptRows BYTE "Enter number of rows: ",0
promptCols BYTE "Enter number of columns: ",0
promptElem BYTE "Enter element: ",0
msgResult BYTE "Result Matrix:",0
rows DWORD ?
cols DWORD ?
choice DWORD ?
matrixA DWORD 100 DUP(0)
matrixB DWORD 100 DUP(0)
matrixRes DWORD 100 DUP(0)

.code
main PROC
    mov edx, OFFSET promptOp
    call WriteString
    call ReadInt
    mov choice, eax

    mov edx, OFFSET promptRows
    call WriteString
    call ReadInt
    mov rows, eax

    mov edx, OFFSET promptCols
    call WriteString
    call ReadInt
    mov cols, eax

    mov ecx, rows
    imul ecx, cols
    mov esi, OFFSET matrixA
    mov edi, OFFSET matrixB

inputA:
    mov edx, OFFSET promptElem
    call WriteString
    call ReadInt
    mov [esi], eax
    add esi, 4
    loop inputA

    mov ecx, rows
    imul ecx, cols
inputB:
    mov edx, OFFSET promptElem
    call WriteString
    call ReadInt
    mov [edi], eax
    add edi, 4
    loop inputB

    mov ecx, rows
    imul ecx, cols
    mov esi, OFFSET matrixA
    mov edi, OFFSET matrixB
    mov ebx, OFFSET matrixRes
compute:
    mov eax, [esi]
    cmp choice, 1
    je addOp
    sub eax, [edi]
    jmp store
addOp:
    add eax, [edi]
store:
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop compute

    mov edx, OFFSET msgResult
    call WriteString
    call Crlf

    mov ecx, rows
    mov esi, OFFSET matrixRes
printRows:
    push ecx
    mov ecx, cols
printCols:
    mov eax, [esi]
    call WriteInt
    mov al, 9
    call WriteChar
    add esi, 4
    loop printCols
    call Crlf
    pop ecx
    loop printRows

    exit
main ENDP
END main
