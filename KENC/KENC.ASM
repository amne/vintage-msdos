	.386p
	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
	endif
	?debug	V 300h
	?debug	S "KENC.CPP"
	?debug	C E900772532084B454E432E435050
	?debug	C E9ED7B2432064B454E432E48
	?debug	C E94019CA1814433A5C42435C494E434C5544455C4D4154482E48
	?debug	C E94019CA1815433A5C42435C494E434C5544455C5F444546532E48
	?debug	C E94019CA1816433A5C42435C494E434C5544455C535452494E472E+
	?debug	C 48
	?debug	C E94019CA1815433A5C42435C494E434C5544455C5F4E554C4C2E48
	?debug	C E94019CA1816433A5C42435C494E434C5544455C5354444C49422E+
	?debug	C 48
KENC_TEXT	segment byte public use16 'CODE'
KENC_TEXT	ends
	assume	cs:KENC_TEXT,ds:KENC_DATA
KENC_DATA	segment word public use16 'FAR_DATA'
d@	label	byte
d@w	label	word
b@	label	byte
b@w	label	word
KENC_DATA	ends
KENC_TEXT	segment byte public use16 'CODE'
	?debug	C E802064B454E432E48ED7B2432
	?debug	L 19
	assume	cs:KENC_TEXT
@crc16$qnzcui	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,2
	push	si
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E318000400160200
	?debug	C E6066C656E6774680A0A0A000006646174615F70+
	?debug	C 180A060000
	mov	si,word ptr [bp+10]
	?debug	B
	?debug	L 23
	mov	cx,00000FFFFh
	?debug	L 24
	or	si,si
	jne	short @1@86
	mov	ax,cx
	not	ax
	pop	ds
	pop	si
	leave	
	ret	
@1@86:
	?debug	L 26
	mov	byte ptr [bp-1],0
	les	bx,dword ptr [bp+6]
	mov	al,byte ptr es:[bx]
	cbw	
	mov	bx,255
	and	bx,ax
	inc	word ptr [bp+6]
	jmp	short @1@226
@1@114:
	?debug	L 28
	mov	ax,cx
	and	ax,1
	mov	dx,bx
	and	dx,1
	xor	ax,dx
	or	ax,ax
	je	short @1@170
	?debug	L 29
	mov	ax,cx
	shr	ax,1
	xor	ax,30738
	mov	cx,ax
	jmp	short @1@198
@1@170:
	?debug	L 30
	shr	cx,1
@1@198:
	?debug	L 26
	inc	byte ptr [bp-1]
	shr	bx,1
@1@226:
	cmp	byte ptr [bp-1],8
	jb	short @1@114
	?debug	L 32
	dec	si
	mov	ax,si
	or	ax,ax
	jne	short @1@86
	?debug	L 33
	not	cx
	?debug	L 34
	?debug	L 35
	mov	ax,cx
	shl	ax,8
	mov	dx,cx
	shr	dx,8
	and	dx,255
	or	ax,dx
	mov	cx,ax
	?debug	L 36
	?debug	L 37
	pop	ds
	pop	si
	leave	
	ret	
	?debug	C E6036372630A080114008F000401000464617461+
	?debug	C 0A08013500660004030001690802FFFF00066461+
	?debug	C 74615F70180A060000066C656E6774680A080110+
	?debug	C 0073000C0600
	?debug	E
	?debug	E
@crc16$qnzcui	endp
	?debug	L 43
	assume	cs:KENC_TEXT
@encdata$qnzcuit1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A0C0000046C656E670A0A0A00+
	?debug	C 000364696E180A060000
	?debug	B
	?debug	L 45
	?debug	L 46
	xor	cx,cx
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+12]
	cmp	cx,word ptr [bp+10]
	jae	short @2@338
@2@114:
	?debug	L 48
	test	cx,1
	je	short @2@170
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[si]
	add	al,78
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	mov	dx,word ptr [bp+14]
	mov	ax,di
	jmp	short @2@198
@2@170:
	mov	dx,word ptr [bp+14]
	mov	ax,di
@2@198:
	mov	es,word ptr [bp+8]
	mov	bl,byte ptr es:[si]
	add	bl,75
	mov	es,dx
	xchg	bx,ax
	mov	byte ptr es:[bx],al
	?debug	L 46
	inc	si
	inc	di
	inc	cx
	cmp	cx,word ptr [bp+10]
	jb	short @2@114
@2@338:
	?debug	L 50
	les	bx,dword ptr [bp+12]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 51
	pop	ds
	pop	di
	pop	si
	pop	bp
	ret	
	?debug	C E601690A08010D0056000401000364696E180A06+
	?debug	C 0000046C656E670A0A0A000004646F7574180A0C+
	?debug	C 0000
	?debug	E
	?debug	E
@encdata$qnzcuit1	endp
	?debug	L 53
	assume	cs:KENC_TEXT
@decdata$qnzcuit1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A0C0000046C656E670A0A0A00+
	?debug	C 000364696E180A060000
	?debug	B
	?debug	L 55
	?debug	L 56
	xor	cx,cx
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+12]
	cmp	cx,word ptr [bp+10]
	jae	short @3@338
@3@114:
	?debug	L 58
	test	cx,1
	je	short @3@170
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[si]
	add	al,178
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	mov	dx,word ptr [bp+14]
	mov	ax,di
	jmp	short @3@198
@3@170:
	mov	dx,word ptr [bp+14]
	mov	ax,di
@3@198:
	mov	es,word ptr [bp+8]
	mov	bl,byte ptr es:[si]
	add	bl,181
	mov	es,dx
	xchg	bx,ax
	mov	byte ptr es:[bx],al
	?debug	L 56
	inc	si
	inc	di
	inc	cx
	cmp	cx,word ptr [bp+10]
	jb	short @3@114
@3@338:
	?debug	L 60
	les	bx,dword ptr [bp+12]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 61
	pop	ds
	pop	di
	pop	si
	pop	bp
	ret	
	?debug	C E601690A08010D0056000401000364696E180A06+
	?debug	C 0000046C656E670A0A0A000004646F7574180A0C+
	?debug	C 0000
	?debug	E
	?debug	E
@decdata$qnzcuit1	endp
	?debug	L 64
	assume	cs:KENC_TEXT
@encdata2$qnzcuit1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A0C0000046C656E670A0A0A00+
	?debug	C 000364696E180A060000
	?debug	B
	?debug	L 66
	?debug	L 68
	xor	dx,dx
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+12]
	cmp	dx,word ptr [bp+10]
	jae	short @4@310
@4@114:
	?debug	L 70
	or	dx,dx
	jne	short @4@170
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[si]
	add	al,78
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	mov	cl,al
	jmp	short @4@198
@4@170:
	?debug	L 71
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[si]
	add	al,cl
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	mov	cl,al
@4@198:
	?debug	L 68
	inc	si
	inc	di
	inc	dx
	cmp	dx,word ptr [bp+10]
	jb	short @4@114
@4@310:
	?debug	L 73
	les	bx,dword ptr [bp+12]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 74
	pop	ds
	pop	di
	pop	si
	pop	bp
	ret	
	?debug	C E601740208013200450004010001690A08010D00+
	?debug	C 4B000402000364696E180A060000046C656E670A+
	?debug	C 0A0A000004646F7574180A0C0000
	?debug	E
	?debug	E
@encdata2$qnzcuit1	endp
	?debug	L 76
	assume	cs:KENC_TEXT
@decdata2$qnzcuit1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A0C0000046C656E670A0A0A00+
	?debug	C 000364696E180A060000
	?debug	B
	?debug	L 78
	?debug	L 80
	xor	dx,dx
	mov	si,word ptr [bp+6]
	mov	di,word ptr [bp+12]
	cmp	dx,word ptr [bp+10]
	jae	short @5@310
@5@114:
	?debug	L 82
	or	dx,dx
	jne	short @5@170
	mov	es,word ptr [bp+8]
	mov	cl,byte ptr es:[si]
	mov	al,cl
	add	al,178
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	jmp	short @5@198
@5@170:
	?debug	L 83
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[si]
	sub	al,cl
	mov	es,word ptr [bp+14]
	mov	byte ptr es:[di],al
	mov	es,word ptr [bp+8]
	mov	cl,byte ptr es:[si]
@5@198:
	?debug	L 80
	inc	si
	inc	di
	inc	dx
	cmp	dx,word ptr [bp+10]
	jb	short @5@114
@5@310:
	?debug	L 85
	les	bx,dword ptr [bp+12]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 86
	pop	ds
	pop	di
	pop	si
	pop	bp
	ret	
	?debug	C E601740208012A00490004010001690A08010D00+
	?debug	C 4F000402000364696E180A060000046C656E670A+
	?debug	C 0A0A000004646F7574180A0C0000
	?debug	E
	?debug	E
@decdata2$qnzcuit1	endp
	?debug	L 89
	assume	cs:KENC_TEXT
@keydata$qnzcuit1t1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,10
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A100000036B6579180A0C0000+
	?debug	C 046C656E670A0A0A00000364696E180A060000
	?debug	B
	?debug	L 91
	les	di,dword ptr [bp+12]
	xor	ax,ax
	mov	cx,00000FFFFh
	repnz 	scasb	
	not	cx
	dec	cx
	mov	word ptr [bp-4],cx
	push	cx
	push	dword ptr [bp+12]
	push	cs
	call	near ptr @crc16$qnzcui
	add	sp,6
	and	ax,255
	mov	word ptr [bp-6],ax
	?debug	L 92
	mov	byte ptr [bp-7],78
	?debug	L 93
	mov	word ptr [bp-2],0
	mov	ax,word ptr [bp+6]
	mov	word ptr [bp-10],ax
	mov	di,word ptr [bp+16]
	mov	ax,word ptr [bp-2]
	cmp	ax,word ptr [bp+10]
	jae	short @6@450
@6@114:
	?debug	L 95
	mov	es,word ptr [bp+8]
	mov	bx,word ptr [bp-10]
	mov	cl,byte ptr es:[bx]
	?debug	L 96
	xor	dx,dx
	mov	si,word ptr [bp+12]
	cmp	dx,word ptr [bp-4]
	jae	short @6@310
@6@198:
	?debug	L 98
	mov	es,word ptr [bp+14]
	add	cl,byte ptr es:[si]
	?debug	L 96
	inc	si
	inc	dx
	cmp	dx,word ptr [bp-4]
	jb	short @6@198
@6@310:
	?debug	L 100
	mov	es,word ptr [bp+18]
	mov	al,byte ptr [bp-7]
	add	al,byte ptr [bp-6]
	add	al,cl
	mov	byte ptr es:[di],al
	?debug	L 101
	mov	al,byte ptr es:[di]
	mov	byte ptr [bp-7],al
	?debug	L 93
	inc	word ptr [bp-10]
	inc	di
	inc	word ptr [bp-2]
	mov	ax,word ptr [bp-2]
	cmp	ax,word ptr [bp+10]
	jb	short @6@114
@6@450:
	?debug	L 103
	les	bx,dword ptr [bp+16]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 104
	pop	ds
	pop	di
	pop	si
	leave	
	ret	
	?debug	C E60274320202F9FF000274310208015900810004+
	?debug	C 0100066B65796372630A02FAFF00066B65796C65+
	?debug	C 6E0A02FCFF00016A0A08015B0071000402000169+
	?debug	C 0A02FEFF000364696E180A060000046C656E670A+
	?debug	C 0A0A0000036B6579180A0C000004646F7574180A+
	?debug	C 100000
	?debug	E
	?debug	E
@keydata$qnzcuit1t1	endp
	?debug	L 106
	assume	cs:KENC_TEXT
@dekeydata$qnzcuit1t1	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,10
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	C E604646F7574180A100000036B6579180A0C0000+
	?debug	C 046C656E670A0A0A00000364696E180A060000
	?debug	B
	?debug	L 108
	les	di,dword ptr [bp+12]
	xor	ax,ax
	mov	cx,00000FFFFh
	repnz 	scasb	
	not	cx
	dec	cx
	mov	word ptr [bp-4],cx
	push	cx
	push	dword ptr [bp+12]
	push	cs
	call	near ptr @crc16$qnzcui
	add	sp,6
	and	ax,255
	mov	word ptr [bp-6],ax
	?debug	L 109
	?debug	L 110
	mov	byte ptr [bp-7],78
	?debug	L 111
	mov	word ptr [bp-2],0
	mov	di,word ptr [bp+6]
	mov	ax,word ptr [bp+16]
	mov	word ptr [bp-10],ax
	mov	ax,word ptr [bp-2]
	cmp	ax,word ptr [bp+10]
	jae	short @7@450
@7@114:
	?debug	L 113
	mov	es,word ptr [bp+8]
	mov	cl,byte ptr es:[di]
	?debug	L 114
	xor	dx,dx
	mov	si,word ptr [bp+12]
	cmp	dx,word ptr [bp-4]
	jae	short @7@310
@7@198:
	?debug	L 116
	mov	es,word ptr [bp+14]
	sub	cl,byte ptr es:[si]
	?debug	L 114
	inc	si
	inc	dx
	cmp	dx,word ptr [bp-4]
	jb	short @7@198
@7@310:
	?debug	L 118
	mov	es,word ptr [bp+18]
	mov	bx,word ptr [bp-10]
	mov	al,byte ptr [bp-7]
	add	al,byte ptr [bp-6]
	mov	dl,cl
	sub	dl,al
	mov	al,dl
	mov	byte ptr es:[bx],al
	?debug	L 119
	mov	es,word ptr [bp+8]
	mov	al,byte ptr es:[di]
	mov	byte ptr [bp-7],al
	?debug	L 111
	inc	di
	inc	word ptr [bp-10]
	inc	word ptr [bp-2]
	mov	ax,word ptr [bp-2]
	cmp	ax,word ptr [bp+10]
	jb	short @7@114
@7@450:
	?debug	L 121
	les	bx,dword ptr [bp+16]
	add	bx,word ptr [bp+10]
	mov	byte ptr es:[bx],0
	?debug	L 122
	pop	ds
	pop	di
	pop	si
	leave	
	ret	
	?debug	C E60274320202F9FF000274310208015600830004+
	?debug	C 0100066B65796372630A02FAFF00066B65796C65+
	?debug	C 6E0A02FCFF00016A0A080158006E000402000169+
	?debug	C 0A02FEFF000364696E180A060000046C656E670A+
	?debug	C 0A0A0000036B6579180A0C000004646F7574180A+
	?debug	C 100000
	?debug	E
	?debug	E
@dekeydata$qnzcuit1t1	endp
	?debug	C E94019CA1815433A5C42435C494E434C5544455C535444494F2E48
	?debug	C E94019CA1816433A5C42435C494E434C5544455C5F4E46494C452E+
	?debug	C 48
	?debug	C E94019CA1815433A5C42435C494E434C5544455C434F4E494F2E48
	?debug	C E94019CA1812433A5C42435C494E434C5544455C494F2E48
	?debug	C E94019CA1815433A5C42435C494E434C5544455C46434E544C2E48
KENC_TEXT	ends
KENC_DATA	segment word public use16 'FAR_DATA'
_set_flags	label	word
	db	0
	db	0
_fnamein	label	dword
	db	4 dup (0)
_fnameout	label	dword
	db	4 dup (0)
_methname	label	dword
	db	4 dup (0)
_password	label	dword
	db	4 dup (0)
_stat	label	word
	db	0
	db	0
_filehin	label	word
	db	0
	db	0
_filehout	label	word
	db	0
	db	0
_statin	label	word
	db	0
	db	0
_statout	label	word
	db	0
	db	0
_method	label	word
	db	0
	db	0
_decode	label	word
	db	0
	db	0
_flen	label	word
	db	0
	db	0
	db	0
	db	0
_btf	label	word
	db	0
	db	0
	db	0
	db	0
_bf	label	word
	db	0
	db	0
	db	0
	db	0
_btd	label	word
	db	0
	db	0
	db	0
	db	0
_bd	label	word
	db	0
	db	0
	db	0
	db	0
KENC_DATA	ends
KENC_TEXT	segment byte public use16 'CODE'
	?debug	C E801084B454E432E43505000772532
	?debug	L 21
	assume	cs:KENC_TEXT
@initmenu$qv	proc	far
	?debug	B
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 23
	call	far ptr _clrscr
	?debug	L 24
	mov	word ptr _set_flags,0
	?debug	L 25
	les	di,dword ptr _fnamein
	xor	ax,ax
	mov	ah,al
	mov	cx,128
	rep 	stosw	
	?debug	L 26
	les	di,dword ptr _fnameout
	mov	ah,al
	mov	cx,128
	rep 	stosw	
	?debug	L 27
	les	di,dword ptr _methname
	mov	ah,al
	mov	cx,128
	rep 	stosw	
	?debug	L 28
	pop	ds
	pop	di
	ret	
	?debug	E
	?debug	E
@initmenu$qv	endp
	?debug	L 29
	assume	cs:KENC_TEXT
@prglogo$qv	proc	far
	?debug	B
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 31
	push	15
	call	far ptr _textcolor
	add	sp,2
	?debug	L 32
	push	ds
	push	offset s@
	call	far ptr _puts
	add	sp,4
	?debug	L 33
	push	ds
	push	offset s@+49
	call	far ptr _puts
	add	sp,4
	?debug	L 34
	push	ds
	push	offset s@+97
	call	far ptr _puts
	add	sp,4
	?debug	L 35
	push	7
	call	far ptr _textcolor
	add	sp,2
	?debug	L 36
	pop	ds
	ret	
	?debug	E
	?debug	E
@prglogo$qv	endp
	?debug	L 37
	assume	cs:KENC_TEXT
@mmenulogo$qv	proc	far
	?debug	B
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 39
	push	8
	call	far ptr _textcolor
	add	sp,2
	?debug	L 40
	push	ds
	push	offset s@+145
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+161
	call	far ptr _cputs
	add	sp,4
	push	8
	call	far ptr _textcolor
	add	sp,2
	?debug	L 41
	push	ds
	push	offset s@+163
	call	far ptr _cputs
	add	sp,4
	push	7
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+168
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+180
	call	far ptr _cputs
	add	sp,4
	push	8
	call	far ptr _textcolor
	add	sp,2
	?debug	L 42
	push	ds
	push	offset s@+182
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+187
	call	far ptr _cputs
	add	sp,4
	?debug	L 43
	push	7
	call	far ptr _textcolor
	add	sp,2
	?debug	L 44
	pop	ds
	ret	
	?debug	E
	?debug	E
@mmenulogo$qv	endp
	?debug	L 46
	assume	cs:KENC_TEXT
@selectmethod$qv	proc	far
	?debug	B
	push	si
	push	di
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
@11@30:
	?debug	B
	?debug	L 48
	?debug	L 50
	mov	word ptr _method,0
	?debug	L 51
	mov	word ptr _decode,0
	?debug	L 52
	call	far ptr _clrscr
	?debug	L 53
	push	cs
	call	near ptr @prglogo$qv
	?debug	L 54
	push	ds
	push	offset s@+201
	call	far ptr _puts
	add	sp,4
	push	ds
	push	offset s@+211
	call	far ptr _puts
	add	sp,4
	?debug	L 55
	push	ds
	push	offset s@+212
	call	far ptr _puts
	add	sp,4
	?debug	L 56
	push	ds
	push	offset s@+234
	call	far ptr _puts
	add	sp,4
	?debug	L 57
	push	ds
	push	offset s@+256
	call	far ptr _puts
	add	sp,4
	?debug	L 58
	push	ds
	push	offset s@+284
	call	far ptr _puts
	add	sp,4
	?debug	L 59
	push	ds
	push	offset s@+312
	call	far ptr _puts
	add	sp,4
	?debug	L 60
	push	ds
	push	offset s@+354
	call	far ptr _puts
	add	sp,4
	?debug	L 61
	call	far ptr _getch
	add	ax,-48
	mov	dx,ax
	?debug	L 62
	mov	bx,dx
	dec	bx
	cmp	bx,5
	jbe short	@@91
	jmp	@11@310
@@91:
	shl	bx,1
	jmp	word ptr cs:@11@C338[bx]
@11@142:
	?debug	L 65
	les	di,dword ptr _methname
	mov	si,offset s@+398
	mov	cx,9
	rep 	movsw	
	movsb	
	?debug	L 66
	mov	word ptr _method,1
	mov	word ptr _decode,0
	?debug	L 67
	jmp	@11@310
@11@170:
	?debug	L 69
	les	di,dword ptr _methname
	mov	si,offset s@+417
	mov	cx,9
	rep 	movsw	
	movsb	
	?debug	L 70
	mov	word ptr _method,1
	mov	word ptr _decode,1
	?debug	L 71
	jmp	@11@310
@11@198:
	?debug	L 73
	les	di,dword ptr _methname
	mov	si,offset s@+436
	mov	cx,12
	rep 	movsw	
	movsb	
	?debug	L 74
	mov	word ptr _method,2
	mov	word ptr _decode,0
	?debug	L 75
	jmp	@11@310
@11@226:
	?debug	L 77
	les	di,dword ptr _methname
	mov	si,offset s@+461
	mov	cx,12
	rep 	movsw	
	movsb	
	?debug	L 78
	mov	word ptr _method,2
	mov	word ptr _decode,1
	?debug	L 79
	jmp	short @11@310
@11@254:
	?debug	L 81
	push	ds
	push	offset s@+486
	call	far ptr _cputs
	add	sp,4
	push	dword ptr _password
	call	far ptr _gets
	add	sp,4
	?debug	L 82
	les	di,dword ptr _methname
	mov	si,offset s@+492
	mov	cx,16
	rep 	movsw	
	movsb	
	?debug	L 83
	mov	word ptr _method,3
	mov	word ptr _decode,0
	?debug	L 84
	jmp	short @11@310
@11@282:
	?debug	L 86
	push	ds
	push	offset s@+525
	call	far ptr _cputs
	add	sp,4
	push	dword ptr _password
	call	far ptr _gets
	add	sp,4
	?debug	L 87
	les	di,dword ptr _methname
	mov	si,offset s@+531
	mov	cx,16
	rep 	movsw	
	movsb	
	?debug	L 88
	mov	word ptr _method,3
	mov	word ptr _decode,1
	?debug	L 89
@11@310:
	?debug	L 91
	cmp	word ptr _method,0
	jne short	@@92
	jmp	@11@30
@@92:
	?debug	L 92
	pop	ds
	pop	di
	pop	si
	ret	
	?debug	C E6046F70743104080190009300040200
	?debug	E
	?debug	E
@selectmethod$qv	endp
@11@C338	label	word
	dw	@11@142
	dw	@11@170
	dw	@11@198
	dw	@11@226
	dw	@11@254
	dw	@11@282
	?debug	L 95
	assume	cs:KENC_TEXT
@start$qv	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,12
	push	si
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 97
	?debug	L 98
	push	512
	call	far ptr _malloc
	add	sp,2
	mov	word ptr [bp-2],dx
	mov	word ptr [bp-4],ax
	?debug	L 99
	push	512
	call	far ptr _malloc
	add	sp,2
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
	?debug	L 100
	mov	dword ptr _flen,large 0
	?debug	L 101
	xor	eax,eax
	mov	dword ptr _btd,eax
	mov	dword ptr _bd,eax
	mov	dword ptr _btf,eax
	mov	dword ptr _bf,eax
	?debug	L 102
	xor	ax,ax
	mov	word ptr _statout,ax
	mov	word ptr _statin,ax
	?debug	L 103
	push	ds
	push	offset s@+564
	push	dword ptr _fnamein
	call	far ptr _fopen
	add	sp,8
	mov	bx,ax
	mov	es,dx
	mov	al,byte ptr es:[bx+4]
	cbw	
	mov	word ptr _filehin,ax
	?debug	L 104
	push	ds
	push	offset s@+567
	push	dword ptr _fnameout
	call	far ptr _fopen
	add	sp,8
	mov	bx,ax
	mov	es,dx
	mov	al,byte ptr es:[bx+4]
	cbw	
	mov	word ptr _filehout,ax
	?debug	L 105
	cmp	word ptr _filehin,0
	jle	short @12@86
	cmp	word ptr _filehout,0
	jg	short @12@114
@12@86:
	mov	ax,1
	jmp	short @12@142
@12@114:
	xor	ax,ax
@12@142:
	mov	si,ax
	?debug	L 106
	or	si,si
	je short	@@93
	jmp	@12@1206
@@93:
	?debug	L 108
	push	word ptr _filehin
	call	far ptr _filelength
	shl	eax,16
	shrd	eax,edx,16
	add	sp,2
	mov	dword ptr _flen,eax
@12@198:
	?debug	L 110
	mov	eax,dword ptr _flen
	sub	eax,dword ptr _bf
	mov	dword ptr [bp-12],eax
	cmp	eax,large 512
	jle	short @12@254
	mov	eax,large 512
	jmp	short @12@282
@12@254:
	mov	eax,dword ptr [bp-12]
@12@282:
	mov	dword ptr _btf,eax
	?debug	L 111
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	word ptr _filehin
	call	far ptr _read
	add	sp,8
	mov	word ptr _statin,ax
	?debug	L 112
	mov	eax,dword ptr _btf
	add	dword ptr _bf,eax
	?debug	L 113
	mov	dword ptr _btd,eax
	?debug	L 114
	cmp	word ptr _statin,0
	jl	short @12@366
	cmp	word ptr _statin,0
	jle	short @12@394
	movsx	eax,word ptr _statin
	cmp	eax,dword ptr _btf
	jge	short @12@394
@12@366:
	mov	si,1
@12@394:
	?debug	L 115
	or	si,si
	je short	@@94
	jmp	@12@1038
@@94:
	?debug	L 117
	mov	ax,word ptr _method
	cmp	ax,1
	je	short @12@562
	cmp	ax,2
	je	short @12@646
	cmp	ax,3
	je	short @12@730
	jmp	@12@814
@12@562:
	?debug	L 120
	cmp	word ptr _decode,0
	je	short @12@618
	push	dword ptr [bp-8]
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @decdata$qnzcuit1
	add	sp,10
	jmp	@12@814
@12@618:
	?debug	L 121
	push	dword ptr [bp-8]
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @encdata$qnzcuit1
	add	sp,10
	jmp	short @12@814
@12@646:
	?debug	L 124
	cmp	word ptr _decode,0
	je	short @12@702
	push	dword ptr [bp-8]
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @decdata2$qnzcuit1
	add	sp,10
	jmp	short @12@814
@12@702:
	?debug	L 125
	push	dword ptr [bp-8]
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @encdata2$qnzcuit1
	add	sp,10
	jmp	short @12@814
@12@730:
	?debug	L 128
	cmp	word ptr _decode,0
	je	short @12@786
	push	dword ptr [bp-8]
	push	dword ptr _password
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @dekeydata$qnzcuit1t1
	add	sp,14
	jmp	short @12@814
@12@786:
	?debug	L 129
	push	dword ptr [bp-8]
	push	dword ptr _password
	push	word ptr _btf
	push	dword ptr [bp-4]
	push	cs
	call	near ptr @keydata$qnzcuit1t1
	add	sp,14
@12@814:
	?debug	L 132
	push	word ptr _btd
	push	dword ptr [bp-8]
	push	word ptr _filehout
	call	far ptr _write
	add	sp,8
	mov	word ptr _statout,ax
	?debug	L 133
	mov	eax,dword ptr _btd
	add	dword ptr _bd,eax
	?debug	L 134
	cmp	word ptr _statout,0
	jl	short @12@898
	cmp	word ptr _statout,0
	jle	short @12@926
	movsx	eax,word ptr _statout
	cmp	eax,dword ptr _btd
	jge	short @12@926
@12@898:
	mov	si,2
@12@926:
	?debug	L 135
	call	far ptr _clrscr
	?debug	L 136
	cmp	word ptr _decode,0
	je	short @12@982
	push	ds
	push	offset s@+571
	call	far ptr _printf
	add	sp,4
	jmp	short @12@1010
@12@982:
	push	ds
	push	offset s@+583
	call	far ptr _printf
	add	sp,4
@12@1010:
	?debug	L 137
	push	dword ptr _methname
	push	ds
	push	offset s@+595
	call	far ptr _printf
	add	sp,8
	?debug	L 138
	push	dword ptr _flen
	push	dword ptr _bf
	push	ds
	push	offset s@+616
	call	far ptr _printf
	add	sp,12
	?debug	L 139
	push	dword ptr _flen
	push	dword ptr _bd
	push	ds
	push	offset s@+652
	call	far ptr _printf
	add	sp,12
	?debug	L 140
	push	dword ptr _btf
	push	ds
	push	offset s@+688
	call	far ptr _printf
	add	sp,8
	?debug	L 141
	push	dword ptr _btd
	push	ds
	push	offset s@+723
	call	far ptr _printf
	add	sp,8
@12@1038:
	?debug	L 143
	or	si,si
	jne	short @12@1122
	mov	eax,dword ptr _bf
	cmp	eax,dword ptr _flen
	jge	short @12@1122
	mov	ax,1
	jmp	short @12@1150
@12@1122:
	xor	ax,ax
@12@1150:
	mov	dx,ax
	?debug	L 144
	or	dx,dx
	je short	@@95
	jmp	@12@198
@@95:
@12@1206:
	?debug	L 146
	push	dword ptr [bp-4]
	call	far ptr _free
	add	sp,4
	?debug	L 147
	push	dword ptr [bp-8]
	call	far ptr _free
	add	sp,4
	?debug	L 148
	mov	ax,si
	?debug	L 149
	pop	ds
	pop	si
	leave	
	ret	
	?debug	C E607656E63627566661802F8FF00046275666618+
	?debug	C 02FCFF00026F6B0408011D031F0304020006646F+
	?debug	C 6F6D6564040801B5003E03040600
	?debug	E
	?debug	E
@start$qv	endp
	?debug	L 154
	assume	cs:KENC_TEXT
@mainmenu$qv	proc	far
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,2
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
@13@30:
	?debug	B
	?debug	L 156
	?debug	L 158
	call	far ptr _clrscr
	?debug	L 159
	push	15
	call	far ptr _textcolor
	add	sp,2
	?debug	L 160
	push	cs
	call	near ptr @prglogo$qv
	?debug	L 161
	push	cs
	call	near ptr @mmenulogo$qv
	?debug	L 162
	push	ds
	push	offset s@+763
	call	far ptr _puts
	add	sp,4
	?debug	L 163
	push	ds
	push	offset s@+764
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	dword ptr _fnamein
	call	far ptr _cputs
	add	sp,4
	push	7
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+789
	call	far ptr _puts
	add	sp,4
	?debug	L 164
	push	ds
	push	offset s@+790
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	dword ptr _fnameout
	call	far ptr _cputs
	add	sp,4
	push	7
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+814
	call	far ptr _puts
	add	sp,4
	?debug	L 165
	push	ds
	push	offset s@+815
	call	far ptr _cputs
	add	sp,4
	push	15
	call	far ptr _textcolor
	add	sp,2
	push	dword ptr _methname
	call	far ptr _cputs
	add	sp,4
	push	7
	call	far ptr _textcolor
	add	sp,2
	push	ds
	push	offset s@+839
	call	far ptr _puts
	add	sp,4
	?debug	L 166
	push	ds
	push	offset s@+840
	call	far ptr _puts
	add	sp,4
	?debug	L 167
	push	ds
	push	offset s@+849
	call	far ptr _puts
	add	sp,4
	?debug	L 168
	push	ds
	push	offset s@+859
	call	far ptr _puts
	add	sp,4
	?debug	L 169
	call	far ptr _getch
	add	al,208
	mov	byte ptr [bp-1],al
	?debug	L 170
	cbw	
	dec	ax
	mov	bx,ax
	cmp	bx,4
	ja	short @13@254
	shl	bx,1
	jmp	word ptr cs:@13@C306[bx]
@13@142:
	?debug	L 173
	push	large 0000A0019h
	call	far ptr _gotoxy
	add	sp,4
	?debug	L 174
	push	dword ptr _fnamein
	call	far ptr _gets
	add	sp,4
	?debug	L 175
	or	word ptr _set_flags,1
	?debug	L 176
	jmp	short @13@254
@13@170:
	?debug	L 178
	push	large 0000B0018h
	call	far ptr _gotoxy
	add	sp,4
	?debug	L 179
	push	dword ptr _fnameout
	call	far ptr _gets
	add	sp,4
	?debug	L 180
	or	word ptr _set_flags,2
	?debug	L 181
	jmp	short @13@254
@13@198:
	?debug	L 183
	push	cs
	call	near ptr @selectmethod$qv
	?debug	L 184
	or	word ptr _set_flags,4
	?debug	L 185
	jmp	short @13@254
@13@226:
	?debug	L 189
	push	cs
	call	near ptr @start$qv
	mov	word ptr _stat,ax
	?debug	L 190
	mov	byte ptr [bp-1],6
	?debug	L 191
@13@254:
	?debug	L 193
	cmp	byte ptr [bp-1],6
	je short	@@96
	jmp	@13@30
@@96:
	?debug	L 194
	pop	ds
	leave	
	ret	
	?debug	C E6036F70740202FFFF00
	?debug	E
	?debug	E
@mainmenu$qv	endp
@13@C306	label	word
	dw	@13@142
	dw	@13@170
	dw	@13@198
	dw	@13@254
	dw	@13@226
	?debug	L 197
	assume	cs:KENC_TEXT
_main	proc	far
	?debug	B
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 199
	?debug	L 200
	mov	ax,seg _directvideo
	mov	es,ax
	mov	word ptr es:_directvideo,1
	?debug	L 201
	push	cs
	call	near ptr @initmenu$qv
	?debug	L 202
	push	cs
	call	near ptr @mainmenu$qv
	?debug	L 203
	pop	ds
	ret	
	?debug	E
	?debug	E
_main	endp
	?debug	L 205
	assume	cs:KENC_TEXT
@clearmem$qv	proc	far
	?debug	B
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	?debug	L 207
	push	dword ptr _fnamein
	call	far ptr _free
	add	sp,4
	?debug	L 208
	push	dword ptr _fnameout
	call	far ptr _free
	add	sp,4
	?debug	L 209
	push	dword ptr _methname
	call	far ptr _free
	add	sp,4
	?debug	L 210
	push	ds
	push	offset s@+870
	call	far ptr _puts
	add	sp,4
	?debug	L 211
	push	ds
	push	offset s@+871
	call	far ptr _puts
	add	sp,4
	?debug	L 212
	pop	ds
	ret	
	?debug	E
	?debug	E
@clearmem$qv	endp
KENC_TEXT	ends
_EXIT_	segment word public use16 'EXITDATA'
	db	1
	db	100
	dd	@clearmem$qv
_EXIT_	ends
KENC_TEXT	segment byte public use16 'CODE'
KENC_TEXT	ends
_INIT_	segment word public use16 'INITDATA'
	db	1
	db	32
	dd	@_STCON_$qv
_INIT_	ends
KENC_TEXT	segment byte public use16 'CODE'
	assume	cs:KENC_TEXT
@_STCON_$qv	proc	far
	?debug	B
	push	ds
	mov	ax,KENC_DATA
	mov	ds,ax
	?debug	B
	push	256
	call	far ptr _malloc
	add	sp,2
	mov	word ptr _fnamein+2,dx
	mov	word ptr _fnamein,ax
	push	256
	call	far ptr _malloc
	add	sp,2
	mov	word ptr _fnameout+2,dx
	mov	word ptr _fnameout,ax
	push	256
	call	far ptr _malloc
	add	sp,2
	mov	word ptr _methname+2,dx
	mov	word ptr _methname,ax
	push	256
	call	far ptr _malloc
	add	sp,2
	mov	word ptr _password+2,dx
	mov	word ptr _password,ax
	pop	ds
	ret	
	?debug	E
	?debug	E
@_STCON_$qv	endp
	?debug	C E9
	?debug	C FA95030000
KENC_TEXT	ends
KENC_DATA	segment word public use16 'FAR_DATA'
s@	label	byte
	db	10
	db	' '
	db	201
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	187
	db	0
	db	' '
	db	186
	db	'      Khrys-TIAN Encoder/Decoder v0.3a      '
	db	186
	db	0
	db	' '
	db	200
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	205
	db	188
	db	0
	db	13
	db	10
	db	' '
	db	218
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	0
	db	191
	db	0
	db	13
	db	10
	db	' '
	db	179
	db	0
	db	' Main menu '
	db	0
	db	179
	db	0
	db	13
	db	10
	db	' '
	db	192
	db	0
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	196
	db	217
	db	10
	db	0
	db	' Methods:'
	db	0
	db	0
	db	' 1. Incriptare simpla'
	db	0
	db	' 2. Decriptare simpla'
	db	0
	db	' 3. Incriptare incrementala'
	db	0
	db	' 4. Decriptare incrementala'
	db	0
	db	' 5. Incriptare folosind cheie de criptare'
	db	0
	db	' 6. Decriptare folosind cheie de decriptare'
	db	0
	db	' incriptare simpla'
	db	0
	db	' decriptare simpla'
	db	0
	db	' incriptare incrementala'
	db	0
	db	' decriptare incrementala'
	db	0
	db	' Key:'
	db	0
	db	' incriptare cu cheie de criptare'
	db	0
	db	' Key:'
	db	0
	db	' incriptare cu cheie de criptare'
	db	0
	db	'rb'
	db	0
	db	'wb+'
	db	0
	db	' Decriptare'
	db	0
	db	' Incriptare'
	db	0
	db	' '
	db	140
	db	'n curs folosind %s'
	db	0
	db	10
	db	' Octeti cititi de pe disc: %lu/%lu'
	db	0
	db	10
	db	' Octeti scrisi pe disk:    %lu/%lu'
	db	0
	db	10
	db	' Buffer brut umplut cu %u octeti!'
	db	0
	db	10
	db	' Buffer prelucrat umplut cu %u octeti!'
	db	0
	db	0
	db	' 1. Fisierul de intrare:'
	db	0
	db	0
	db	' 2. Fisierul de iesire:'
	db	0
	db	0
	db	' 3. Metoda de criptare:'
	db	0
	db	0
	db	' 4. Info'
	db	0
	db	' 5. Start'
	db	0
	db	' 6. Iesire'
	db	0
	db	0
	db	' Multumesc pentru ca folositi Khrys-TIAN Encoder/Decoder v0.3'
	db	'!!!'
	db	0
KENC_DATA	ends
KENC_TEXT	segment byte public use16 'CODE'
KENC_TEXT	ends
	public	@clearmem$qv
	public	_main
	public	@mainmenu$qv
	public	@start$qv
	public	@selectmethod$qv
	public	@mmenulogo$qv
	public	@prglogo$qv
	public	@initmenu$qv
	public	_bd
	public	_btd
	public	_bf
	public	_btf
	public	_flen
	public	_decode
	public	_method
	public	_statout
	public	_statin
	public	_filehout
	public	_filehin
	public	_stat
	public	_password
	public	_methname
	public	_fnameout
	public	_fnamein
	public	_set_flags
	extrn	_write:far
	extrn	_read:far
	extrn	_filelength:far
	extrn	_cputs:far
	extrn	_textcolor:far
	extrn	_getch:far
	extrn	_gotoxy:far
	extrn	_clrscr:far
	extrn	_directvideo:word
	extrn	_puts:far
	extrn	_printf:far
	extrn	_gets:far
	extrn	_fopen:far
	public	@dekeydata$qnzcuit1t1
	public	@keydata$qnzcuit1t1
	public	@decdata2$qnzcuit1
	public	@encdata2$qnzcuit1
	public	@decdata$qnzcuit1
	public	@encdata$qnzcuit1
	public	@crc16$qnzcui
	extrn	_malloc:far
	extrn	_free:far
_atoi	equ	atoi
_abs	equ	abs
_s@	equ	s@
	?debug	C EA050D
	?debug	C E31900000023010400
	?debug	C EC0C40636C6561726D656D247176191800
	?debug	C E31A00000023010400
	?debug	C EC055F6D61696E1A1800
	?debug	C E31B00000023010400
	?debug	C EC0C406D61696E6D656E752471761B1800
	?debug	C E31C00000023040400
	?debug	C EC094073746172742471761C1800
	?debug	C E31D00000023010400
	?debug	C EC104073656C6563746D6574686F642471761D18+
	?debug	C 00
	?debug	C E31E00000023010400
	?debug	C EC0D406D6D656E756C6F676F2471761E1800
	?debug	C E31F00000023010400
	?debug	C EC0B407072676C6F676F2471761F1800
	?debug	C E32000000023010400
	?debug	C EC0C40696E69746D656E75247176201800
	?debug	C EC035F6264060000
	?debug	C EC045F627464060000
	?debug	C EC035F6266060000
	?debug	C EC045F627466060000
	?debug	C EC055F666C656E060000
	?debug	C EC075F6465636F6465040000
	?debug	C EC075F6D6574686F64040000
	?debug	C EC085F737461746F7574040000
	?debug	C EC075F73746174696E040000
	?debug	C EC095F66696C65686F7574040000
	?debug	C EC085F66696C6568696E040000
	?debug	C EC055F73746174040000
	?debug	C EC095F70617373776F7264180000
	?debug	C EC095F6D6574686E616D65180000
	?debug	C EC095F666E616D656F7574180000
	?debug	C EC085F666E616D65696E180000
	?debug	C EC0A5F7365745F666C616773040000
	?debug	C E32100000023040400
	?debug	C EB065F77726974652100
	?debug	C E32200000023040400
	?debug	C EB055F726561642200
	?debug	C E32300000023060400
	?debug	C EB0B5F66696C656C656E6774682300
	?debug	C E324056674696D6504001E01
	?debug	C E32500000023040400
	?debug	C EB065F63707574732500
	?debug	C E32600000023010400
	?debug	C EB0A5F74657874636F6C6F722600
	?debug	C E32700000023040400
	?debug	C EB065F67657463682700
	?debug	C E32800000023010400
	?debug	C EB075F676F746F78792800
	?debug	C E32900000023010400
	?debug	C EB075F636C727363722900
	?debug	C EB0C5F646972656374766964656F0400
	?debug	C E32A09746578745F696E666F0B001E08
	?debug	C E32B00000023040400
	?debug	C EB055F707574732B00
	?debug	C E32C00000023040401
	?debug	C EB075F7072696E74662C00
	?debug	C E32D00000023180400
	?debug	C EB055F676574732D00
	?debug	C E3300446494C4514001E14
	?debug	C E331000400160800
	?debug	C E32F000400163000
	?debug	C E32E000000232F0400
	?debug	C EB065F666F70656E2E00
	?debug	C E33200000023010400
	?debug	C EC154064656B65796461746124716E7A63756974+
	?debug	C 317431321800
	?debug	C E33300000023010400
	?debug	C EC13406B65796461746124716E7A637569743174+
	?debug	C 31331800
	?debug	C E33400000023010400
	?debug	C EC1240646563646174613224716E7A6375697431+
	?debug	C 341800
	?debug	C E33500000023010400
	?debug	C EC1240656E63646174613224716E7A6375697431+
	?debug	C 351800
	?debug	C E33600000023010400
	?debug	C EC11406465636461746124716E7A637569743136+
	?debug	C 1800
	?debug	C E33700000023010400
	?debug	C EC1140656E636461746124716E7A637569743137+
	?debug	C 1800
	?debug	C E338000000230A0400
	?debug	C EC0D40637263313624716E7A637569381800
	?debug	C E33900000023010400
	?debug	C E33A00000023040400
	?debug	C E33C000400160100
	?debug	C E33B000000233C0400
	?debug	C EB075F6D616C6C6F633B00
	?debug	C E33D00000023010400
	?debug	C EB055F667265653D00
	?debug	C E33E00000023040400
	?debug	C E33F00000023040400
	?debug	C E3400B5F657863657074696F6E6C24001E1E
	?debug	C E34109657863657074696F6E1E001E24
	?debug	C E60446494C453006000666706F735F7406060005+
	?debug	C 64776F72640C060004776F72640A060004627974+
	?debug	C 650806000777636861725F740206000673697A65+
	?debug	C 5F740A0600056674696D6524070009746578745F+
	?debug	C 696E666F2A07000B5F657863657074696F6E6C40+
	?debug	C 070009657863657074696F6E410700
	?debug	F @_STCON_$qv 0 24 0
	?debug	F @randomize$qv 57 24 0
	?debug	F @random$qi 58 24 0
	?debug	F atoi 62 24 0
	?debug	F abs 63 24 0
	?debug	C E2050766745F747365630A060666745F6D696E0A+
	?debug	C 050766745F686F75720A050666745F6461790A04+
	?debug	C 0866745F6D6F6E74680A070766745F796561720A+
	?debug	C C004000000
	?debug	C E2000777696E6C65667408000677696E746F7008+
	?debug	C 000877696E726967687408000977696E626F7474+
	?debug	C 6F6D0800096174747269627574650800086E6F72+
	?debug	C 6D61747472080008637572726D6F646508000C73+
	?debug	C 637265656E68656967687408000B73637265656E+
	?debug	C 7769647468080004637572780800046375727908+
	?debug	C C00B000000
	?debug	C E200056C6576656C040005666C6167730A000266+
	?debug	C 64020004686F6C640800056273697A6504000662+
	?debug	C 756666657231000463757270310006697374656D+
	?debug	C 700A0005746F6B656E04C014000000
	?debug	C E20004747970650400046E616D65180004617267+
	?debug	C 311000046172673210000672657476616C10C024+
	?debug	C 000000
	?debug	C E20004747970650400046E616D65180004617267+
	?debug	C 310F0004617267320F000672657476616C0FC01E+
	?debug	C 000000
	end
