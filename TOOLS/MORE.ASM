seg_a     Segment Byte Public
          ASSUME  CS:seg_a,DS:seg_a
          ORG 100h
more      PROC FAR
start:    MOV Byte Ptr data_1,19h
          MOV AH,0Fh
          INT 10h
          MOV data_2,AH
          MOV DX,Offset data_5+27h
          MOV AH,9
          INT 21h
          XOR BX,BX
          MOV AH,45h
          INT 21h
          MOV BP,AX
          MOV AH,3Eh
          INT 21h
          MOV BX,2
          MOV AH,45h
          INT 21h
loc_2:    CLD
          MOV DX,21Ah
          MOV CX,1000h
          MOV BX,BP
          MOV AH,3Fh
          INT 21h
          OR  AX,AX
          JNZ loc_4
loc_3:    INT 20h
loc_4:    MOV CX,AX
          MOV SI,DX
loc_5:    LODSB
          CMP AL,1Ah
          JE loc_3
          CMP AL,0Dh
          JNE loc_6
          MOV Byte Ptr data_4,1
          JMP Short loc_10
loc_6:    CMP AL,0Ah
          JNE loc_7
          INC data_3
          JMP Short loc_10
loc_7:    CMP AL,8
          JNE loc_8
          CMP Byte Ptr data_4,1
          JE  loc_10
          DEC data_4
          JMP Short loc_10
loc_8:    CMP AL,9
          JNE loc_9
          MOV AH,data_4
          ADD AH,7
          AND AH,0F8h
          INC AH
          MOV data_4,AH
          JMP Short loc_10
loc_9:    CMP AL,7
          JE  loc_10
          INC data_4
          MOV AH,data_4
          CMP AH,data_2
          JBE loc_10
          INC data_3
          MOV Byte Ptr data_4,1
loc_10:   MOV DL,AL
          MOV AH,2
          INT 21h
          MOV AH,data_3
          CMP AH,data_1
          JB  loc_11
          MOV DX,Offset data_5
          MOV AH,9
          INT 21h
          MOV AH,0Ch
          MOV AL,1
          INT 21h
          MOV DX,Offset data_5+27h
          MOV AH,9
          INT 21h
          MOV Byte Ptr data_4,1
          MOV Byte Ptr data_3,1
          DEC SI
          INC CX
loc_11:   DEC CX
          JZ  loc_12
          JMP loc_5
loc_12:   JMP loc_2
data_1    DB        18h
data_2    DB        50h
data_3    DB        1
data_4    DB        1, 0, 0, 0, 0, 0
data_5    DB        0Dh, '-- More --$'
          DB        'MORE: Incorrect DOS Version$'
more      endp
seg_a     ends
          end start