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

#GetRamCoords
    // Ram is 128 blocks (32*4). Wrap around ram if we go to negative. Exceeding limit will break programs.
    if rampointer|<|0 setadd rampointer 128

    set ramx {rampointer}
    setmod ramx 32

    set ramz {rampointer}
    setdiv ramz 32
    setrounddown ramz
    setadd ramz 10
quit

#IncrementRam
    call #GetRamCoords
    setblockid ramblock {ramx} {ramy} {ramz}
    if ramblock|=|0 set ramblock 1

    setadd ramblock 1
    setmod ramblock 256

    placeblock {ramblock} {ramx} {ramy} {ramz}
quit

#DecrementRam
    call #GetRamCoords
    setblockid ramblock {ramx} {ramy} {ramz}
    if ramblock|=|0 set ramblock 1

    setsub ramblock 1
    if ramblock|=|0 set ramblock 256

    placeblock {ramblock} {ramx} {ramy} {ramz}
quit

#LoopEnter
    call #GetRamCoords
    setblockid ramblock {ramx} {ramy} {ramz}

    if ramblock|=|1 set rompointer {loop_{rompointer}}
quit

#LoopEnd
    call #GetRamCoords
    setblockid ramblock {ramx} {ramy} {ramz}

    ifnot ramblock|=|1 set rompointer {loop_{rompointer}}
quit

#Run
    cmd z 1
    cmd m 0 2 10
    cmd m 31 2 13

    resetdata packages loop_*
    resetdata packages output*

    set romy 2
    set ramy 2
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

#ExecLoop
    call #GetRomCoords
    setblockid romblock {romx} {romy} {romz}

    if romblock|=|0 goto #Quit
    if romblock|=|504 setadd rampointer 1
    if romblock|=|505 setsub rampointer 1
    if romblock|=|506 call #IncrementRam
    if romblock|=|507 call #DecrementRam
    if romblock|=|508 call #Print
    //if romblock|=|509 call #Input
    if romblock|=|510 call #LoopEnter
    if romblock|=|511 call #LoopEnd

    setadd rompointer 1
    goto #ExecLoop
quit

#Quit
    msg &i[Debug] &7Done executing
    msg &r[Output] &7{output_0}{output_1}{output_2}{output_3}{output_4}{output_5}{output_6}{output_7}{output_8}{output_9}{output_10}{output_11}{output_12}{output_13}{output_14}{output_15}{output_16}{output_17}{output_18}{output_19}{output_20}{output_21}{output_22}{output_23}{output_24}{output_25}{output_26}{output_27}{output_28}{output_29}{output_30}{output_31}
terminate

#Print
    call #GetRamCoords
    setblockid ramblock {ramx} {ramy} {ramz}
    setsub ramblock 1

    if ramblock|>=|48 call #MaybeNumber
    if ramblock|>=|65 call #MaybeUpper
    if ramblock|>=|97 call #MaybeLower
quit

#PrintChar
    set output_{outputpointer} {runArg1}
    setadd outputpointer 1
quit

#MaybeNumber
    if ramblock|<=|57 call #Number
quit

#Number
    if ramblock|=|48 call #PrintChar|0
    if ramblock|=|49 call #PrintChar|1
    if ramblock|=|50 call #PrintChar|2
    if ramblock|=|51 call #PrintChar|3
    if ramblock|=|52 call #PrintChar|4
    if ramblock|=|53 call #PrintChar|5
    if ramblock|=|54 call #PrintChar|6
    if ramblock|=|55 call #PrintChar|7
    if ramblock|=|56 call #PrintChar|8
    if ramblock|=|57 call #PrintChar|9
quit

#MaybeUpper
    if ramblock|<=|90 call #Upper
quit

#Upper
    if ramblock|=|65 call #PrintChar|A
    if ramblock|=|66 call #PrintChar|B
    if ramblock|=|67 call #PrintChar|C
    if ramblock|=|68 call #PrintChar|D
    if ramblock|=|69 call #PrintChar|E
    if ramblock|=|70 call #PrintChar|F
    if ramblock|=|71 call #PrintChar|G
    if ramblock|=|72 call #PrintChar|H
    if ramblock|=|73 call #PrintChar|I
    if ramblock|=|74 call #PrintChar|J
    if ramblock|=|75 call #PrintChar|K
    if ramblock|=|76 call #PrintChar|L
    if ramblock|=|77 call #PrintChar|M
    if ramblock|=|78 call #PrintChar|N
    if ramblock|=|79 call #PrintChar|O
    if ramblock|=|80 call #PrintChar|P
    if ramblock|=|81 call #PrintChar|Q
    if ramblock|=|82 call #PrintChar|R
    if ramblock|=|83 call #PrintChar|S
    if ramblock|=|84 call #PrintChar|T
    if ramblock|=|85 call #PrintChar|U
    if ramblock|=|86 call #PrintChar|V
    if ramblock|=|87 call #PrintChar|W
    if ramblock|=|88 call #PrintChar|X
    if ramblock|=|89 call #PrintChar|Y
    if ramblock|=|90 call #PrintChar|Z
quit

#MaybeLower
    if ramblock|<=|122 call #Lower
quit

#Lower
    if ramblock|=|97 call #PrintChar|a
    if ramblock|=|98 call #PrintChar|b
    if ramblock|=|99 call #PrintChar|c
    if ramblock|=|100 call #PrintChar|d
    if ramblock|=|101 call #PrintChar|e
    if ramblock|=|102 call #PrintChar|f
    if ramblock|=|103 call #PrintChar|g
    if ramblock|=|104 call #PrintChar|h
    if ramblock|=|105 call #PrintChar|i
    if ramblock|=|106 call #PrintChar|j
    if ramblock|=|107 call #PrintChar|k
    if ramblock|=|108 call #PrintChar|l
    if ramblock|=|109 call #PrintChar|m
    if ramblock|=|110 call #PrintChar|n
    if ramblock|=|111 call #PrintChar|o
    if ramblock|=|112 call #PrintChar|p
    if ramblock|=|113 call #PrintChar|q
    if ramblock|=|114 call #PrintChar|r
    if ramblock|=|115 call #PrintChar|s
    if ramblock|=|116 call #PrintChar|t
    if ramblock|=|117 call #PrintChar|u
    if ramblock|=|118 call #PrintChar|v
    if ramblock|=|119 call #PrintChar|w
    if ramblock|=|120 call #PrintChar|x
    if ramblock|=|121 call #PrintChar|y
    if ramblock|=|122 call #PrintChar|z
quit