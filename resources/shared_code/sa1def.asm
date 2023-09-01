macro invoke_snes(addr)
	LDA.b #<addr>
	STA $0183
	LDA.b #<addr>/256
	STA $0184
	LDA.b #<addr>/65536
	STA $0185
	LDA #$D0
	STA $2209
-	LDA $018A
	BEQ -
	STZ $018A
endmacro

; Macro for calling SA-1 CPU. Label should point to a routine which ends in RTL.
; Data bank is not set, so use PHB/PHK/PLB ... PLB in your SA-1 code.
macro invoke_sa1(label)
	LDA.b #<label>
	STA $3180
	LDA.b #<label>>>8
	STA $3181
	LDA.b #<label>>>16
	STA $3182
	JSR $1E80
endmacro


if read1($00FFD5) == $23		; check if the rom is sa-1
	if read1($00FFD7) == $0D ; full 6/8 mb sa-1 rom
		fullsa1rom
		!fullsa1 = 1
	else
		!fullsa1 = 0
		sa1rom
	endif
	!sa1 = 1
	!SA1 = 1
	!SA_1 = 1
	!Base1 = $3000
	!Base2 = $6000
	!dp = $3000
	!addr = $6000
	
	!BankA = $400000
	!BankB = $000000
	!bank = $000000
	
	!Bank8 = $00
	!bank8 = $00
	
	!SprSize = $16
else
	lorom
	!sa1 = 0
	!SA1 = 0
	!SA_1 = 0
	!Base1 = $0000
	!Base2 = $0000
	!dp = $0000
	!addr = $0000

	!BankA = $7E0000
	!BankB = $800000
	!bank = $800000
	
	!Bank8 = $80
	!bank8 = $80
	
	!SprSize = $0C
endif
