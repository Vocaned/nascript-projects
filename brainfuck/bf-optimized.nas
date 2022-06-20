// 0 = stop
// 504 = >
// 505 = <
// 506 = +
// 507 = -
// 508 = .
// 509 = , [unimplemented]
// 510 = [
// 511 = ]

#Run
    resetdata packages loop_*
    resetdata packages ram_*
    resetdata packages output

    ifnot chars_48|=|0 goto #NoInit

    set romy 2
    set rompointer 0
    set loop_tmp_index 0
    msg &i[Debug] &7Precalculating loops
    goto #Loops
quit

#Loops
    call #GetRomCoords
    setblockid romblock {romx} {romy} {romz}

    if romblock|=|0 goto #Execute
    if romblock|=|510 call #SetTmpLoop
    if romblock|=|511 call #SetLoop

    setadd rompointer 1
    goto #Loops
quit

#SetLoop
    set loop_{rompointer} {loop_tmp_{loop_tmp_index}}
    set loop_{loop_tmp_{loop_tmp_index}} {rompointer}
    msg &i[Debug] &7Loop({loop_tmp_{loop_tmp_index}}, {rompointer})
    setsub loop_tmp_index 1
quit

#SetTmpLoop
    setadd loop_tmp_index 1
    set loop_tmp_{loop_tmp_index} {rompointer}
quit

#GetRomCoords
    set romx {rompointer}
    setmod romx 32

    set romz {rompointer}
    setdiv romz 32
    setrounddown romz
quit

#Execute
    set rompointer 0
    set rampointer 0
    msg &i[Debug] &7Executing code
    goto #ExecLoop
quit

#ExecLoop
    call #GetRomCoords
    setblockid romblock {romx} {romy} {romz}

    call #{romblock}

    setadd rompointer 1
    goto #ExecLoop
quit

#504
// >
    setadd rampointer 1
quit

#505
// <
    setsub rampointer 1
quit

#506
// +
    setadd ram_{rampointer} 1
    setmod ram_{rampointer} 256
quit

#507
// -
    setsub ram_{rampointer} 1
    if ram_{rampointer}|<|0 setadd ram_{rampointer} 256
quit

#510
// [
    if ram_{rampointer}|=|0 set rompointer {loop_{rompointer}}
quit

#511
// ]
    ifnot ram_{rampointer}|=|0 set rompointer {loop_{rompointer}}
quit

#0
    msg &i[Debug] &7Done executing
    msg &r[Output] &7{output}
terminate

#508
    set output {output}{chars_{ram_{rampointer}}}
quit

#NoInit
    msg "Interpreter initialized. Please execute the program again."
    goto #Init
terminate

#Init
    set chars_32 _
    set chars_33 !
    set chars_44 ,
    set chars_46 .
    set chars_63 ?

    set chars_48 0
    set chars_49 1
    set chars_50 2
    set chars_51 3
    set chars_52 4
    set chars_53 5
    set chars_54 6
    set chars_55 7
    set chars_56 8
    set chars_57 9

    set chars_65 A
    set chars_66 B
    set chars_67 C
    set chars_68 D
    set chars_69 E
    set chars_70 F
    set chars_71 G
    set chars_72 H
    set chars_73 I
    set chars_74 J
    set chars_75 K
    set chars_76 L
    set chars_77 M
    set chars_78 N
    set chars_79 O
    set chars_80 P
    set chars_81 Q
    set chars_82 R
    set chars_83 S
    set chars_84 T
    set chars_85 U
    set chars_86 V
    set chars_87 W
    set chars_88 X
    set chars_89 Y
    set chars_90 Z

    set chars_97 a
    set chars_98 b
    set chars_99 c
    set chars_100 d
    set chars_101 e
    set chars_102 f
    set chars_103 g
    set chars_104 h
    set chars_105 i
    set chars_106 j
    set chars_107 k
    set chars_108 l
    set chars_109 m
    set chars_110 n
    set chars_111 o
    set chars_112 p
    set chars_113 q
    set chars_114 r
    set chars_115 s
    set chars_116 t
    set chars_117 u
    set chars_118 v
    set chars_119 w
    set chars_120 x
    set chars_121 y
    set chars_122 z
terminate