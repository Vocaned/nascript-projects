// 0 = stop
// 504 = >
// 505 = <
// 506 = +
// 507 = -
// 508 = .
// 509 = , [unimplemented]
// 510 = [
// 511 = ]

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

#506
    setadd ram_{rampointer} 1
    setmod ram_{rampointer} 256
quit

#507
    setsub ram_{rampointer} 1
    if ram_{rampointer}|<|0 setadd ram_{rampointer} 256
quit

#510
    if ram_{rampointer}|=|0 set rompointer {loop_{rompointer}}
quit

#511
    ifnot ram_{rampointer}|=|0 set rompointer {loop_{rompointer}}
quit

#Run
    resetdata packages loop_*
    resetdata packages ram_*
    resetdata packages output*

    set romy 2
    set rompointer 0
    set outputpointer 0
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

#Execute
    set rompointer 0
    set rampointer 0
    msg &i[Debug] &7Executing code
    goto #ExecLoop
quit

#504
    setadd rampointer 1
quit

#505
    setsub rampointer 1
quit

#ExecLoop
    call #GetRomCoords
    setblockid romblock {romx} {romy} {romz}

    call #{romblock}

    setadd rompointer 1
    goto #ExecLoop
quit

#0
    msg &i[Debug] &7Done executing
    msg &r[Output] &7{output_0}{output_1}{output_2}{output_3}{output_4}{output_5}{output_6}{output_7}{output_8}{output_9}{output_10}{output_11}{output_12}{output_13}{output_14}{output_15}{output_16}{output_17}{output_18}{output_19}{output_20}{output_21}{output_22}{output_23}{output_24}{output_25}{output_26}{output_27}{output_28}{output_29}{output_30}{output_31}
terminate

#508
    if ram_{rampointer}|>=|97 call #MaybeLower
    if ram_{rampointer}|>=|65 call #MaybeUpper
    if ram_{rampointer}|>=|48 call #MaybeNumber
quit

#PrintChar
    set output_{outputpointer} {runArg1}
    setadd outputpointer 1
quit

#MaybeNumber
    if ram_{rampointer}|<=|57 call #Number
quit

#Number
    if ram_{rampointer}|=|48 call #PrintChar|0
    if ram_{rampointer}|=|49 call #PrintChar|1
    if ram_{rampointer}|=|50 call #PrintChar|2
    if ram_{rampointer}|=|51 call #PrintChar|3
    if ram_{rampointer}|=|52 call #PrintChar|4
    if ram_{rampointer}|=|53 call #PrintChar|5
    if ram_{rampointer}|=|54 call #PrintChar|6
    if ram_{rampointer}|=|55 call #PrintChar|7
    if ram_{rampointer}|=|56 call #PrintChar|8
    if ram_{rampointer}|=|57 call #PrintChar|9
quit

#MaybeUpper
    if ram_{rampointer}|<=|90 call #Upper
quit

#Upper
    if ram_{rampointer}|=|65 call #PrintChar|A
    if ram_{rampointer}|=|66 call #PrintChar|B
    if ram_{rampointer}|=|67 call #PrintChar|C
    if ram_{rampointer}|=|68 call #PrintChar|D
    if ram_{rampointer}|=|69 call #PrintChar|E
    if ram_{rampointer}|=|70 call #PrintChar|F
    if ram_{rampointer}|=|71 call #PrintChar|G
    if ram_{rampointer}|=|72 call #PrintChar|H
    if ram_{rampointer}|=|73 call #PrintChar|I
    if ram_{rampointer}|=|74 call #PrintChar|J
    if ram_{rampointer}|=|75 call #PrintChar|K
    if ram_{rampointer}|=|76 call #PrintChar|L
    if ram_{rampointer}|=|77 call #PrintChar|M
    if ram_{rampointer}|=|78 call #PrintChar|N
    if ram_{rampointer}|=|79 call #PrintChar|O
    if ram_{rampointer}|=|80 call #PrintChar|P
    if ram_{rampointer}|=|81 call #PrintChar|Q
    if ram_{rampointer}|=|82 call #PrintChar|R
    if ram_{rampointer}|=|83 call #PrintChar|S
    if ram_{rampointer}|=|84 call #PrintChar|T
    if ram_{rampointer}|=|85 call #PrintChar|U
    if ram_{rampointer}|=|86 call #PrintChar|V
    if ram_{rampointer}|=|87 call #PrintChar|W
    if ram_{rampointer}|=|88 call #PrintChar|X
    if ram_{rampointer}|=|89 call #PrintChar|Y
    if ram_{rampointer}|=|90 call #PrintChar|Z
quit

#MaybeLower
    if ram_{rampointer}|<=|122 call #Lower
quit

#Lower
    if ram_{rampointer}|=|97 call #PrintChar|a
    if ram_{rampointer}|=|98 call #PrintChar|b
    if ram_{rampointer}|=|99 call #PrintChar|c
    if ram_{rampointer}|=|100 call #PrintChar|d
    if ram_{rampointer}|=|101 call #PrintChar|e
    if ram_{rampointer}|=|102 call #PrintChar|f
    if ram_{rampointer}|=|103 call #PrintChar|g
    if ram_{rampointer}|=|104 call #PrintChar|h
    if ram_{rampointer}|=|105 call #PrintChar|i
    if ram_{rampointer}|=|106 call #PrintChar|j
    if ram_{rampointer}|=|107 call #PrintChar|k
    if ram_{rampointer}|=|108 call #PrintChar|l
    if ram_{rampointer}|=|109 call #PrintChar|m
    if ram_{rampointer}|=|110 call #PrintChar|n
    if ram_{rampointer}|=|111 call #PrintChar|o
    if ram_{rampointer}|=|112 call #PrintChar|p
    if ram_{rampointer}|=|113 call #PrintChar|q
    if ram_{rampointer}|=|114 call #PrintChar|r
    if ram_{rampointer}|=|115 call #PrintChar|s
    if ram_{rampointer}|=|116 call #PrintChar|t
    if ram_{rampointer}|=|117 call #PrintChar|u
    if ram_{rampointer}|=|118 call #PrintChar|v
    if ram_{rampointer}|=|119 call #PrintChar|w
    if ram_{rampointer}|=|120 call #PrintChar|x
    if ram_{rampointer}|=|121 call #PrintChar|y
    if ram_{rampointer}|=|122 call #PrintChar|z
quit