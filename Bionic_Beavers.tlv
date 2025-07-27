\m5_TLV_version 1d: tl-x.org
\m5
   / A development template for:
   /
   / /----------------------------------------------------------------------------\
   / | The First Annual Makerchip ASIC Design Showdown, Summer 2025, Space Battle |
   / \----------------------------------------------------------------------------/
   /
   / Each player or team modifies this template to provide their own custom spacecraft
   / control circuitry. This template is for teams using TL-Verilog. A Verilog-based
   / template is provided separately. Monitor the Showdown Slack channel for updates.
   / Use the latest template for submission.
   /
   / Just 3 steps:
   /   - Replace all YOUR_GITHUB_ID and YOUR_TEAM_NAME.
   /   - Code your logic in the module below.
   /   - Submit by Sun. July 26, 11 PM IST/1:30 PM EDT.
   /
   / Showdown details: https://www.redwoodeda.com/showdown-info and in the reposotory README.
   /
   /
   / Your circuit should drive the following signals for each of your ships, in /ship[2:0]:
   / /ships[2:0]
   /    $xx_acc[3:0], $yy_acc[3:0]: Attempted acceleration for each of your ships (if sufficient energy);
   /                                capped by max_acceleration (see showdown_lib.tlv). (use "\$signed($yy_acc) for signed math)
   /    $attempt_fire: Attempt to fire (if sufficient energy remains).
   /    $fire_dir[1:0]: Direction to fire (if firing). (For the first player: 0 = right, 1 = down, 2 = left, 3 = up).
   /    $attempt_cloak: Attempted actions for each of your ships (if sufficient energy remains).
   /    $attempt_shield: Attempt to use shields (if sufficient energy remains).
   / Based on the following inputs, previous state from the enemy in /prev_enemy_ship[2:0]:
   / /ship[2:0]
   /    *clk:           Clock; used implicitly by TL-Verilog constructs, but you can use this in embedded Verilog.
   /    $reset:         Reset.
   /    $xx_p[7:0], $yy_p[7:0]: Position of your ships as affected by previous cycle's acceleration. (signed value, unsigned type)
   /    $energy[7:0]:   The energy supply of each ship, as updated by inputs last cycle.
   /    $destroyed:     Asserted if and when the ships are destroyed.
   / /enemy_ship[2:0]: Reflecting enemy input in the previous cycle.
   /    $xx_p[7:0], $yy_p[7:0]: Positions of enemy ships. (signed value, unsigned type)
   /    $cloaked: Whether the enemy ships are cloaked; if asserted enemy xx_p and xy_p did not update.
   /    $destroyed: Whether the enemy ship has been destroyed.

   / See also the game parameters in the header of `showdown_lib.tlv`.

   use(m5-1.0)
   
   var(viz_mode, devel)  /// Enables VIZ for development.
                         /// Use "devel" or "demo". ("demo" will be used in competition.)


// Modify this TL-Verilog macro to implement your control circuitry.
// Replace YOUR_GITHUB_ID with your GitHub ID, excluding non-word characters (alphabetic, numeric,
// and "_" only)

\TLV team_60561724(/_top)
   /ship[2:0]
      /enemy_offset[2:0]
         // Calculate Y offset: enemy_y - ship_y (signed difference)
         // Using signed arithmetic for position calculations
         $y_offset[7:0] = \$signed(/_top/enemy_ship[enemy_offset]$yy_p) - \$signed(/_top/ship[ship]$yy_p);

   /ship[*]
      $enemy_radius = 0;
      $dir_good = 1;
      $ready = 1;
      
      $fire_dir[1:0] = 0; // right
      $should_shoot = $ready && $enemy_radius < 32 && $dir_good;
      $attempt_fire = $should_shoot && $energy > 25 + 4;
      
      $xx_acc[7:0] = #ship == 2 ?  //blue
                      *cyc_cnt == 1 ? (-8'd4) :
                      *cyc_cnt == 2 ? (-8'd2) :
                      *cyc_cnt == 3 ? (-8'd1) :
                      *cyc_cnt == 4 ? (8'd0) :
                      *cyc_cnt == 5 ? (-8'd1) :
                      *cyc_cnt == 6 ? (8'd0) :
                      *cyc_cnt == 7 ? (8'd0) :
                      *cyc_cnt == 8 ? (8'd2) :
                      *cyc_cnt == 9 ? (8'd1) :
                      *cyc_cnt == 10 ? (8'd1) :
                      
                      *cyc_cnt == 11 ? (8'd2) :
                      *cyc_cnt == 12 ? (8'd1) :
                      *cyc_cnt == 13 ? (-8'd2) :
                      *cyc_cnt == 14 ? (-8'd1) :
                      *cyc_cnt == 15 ? (8'd2) :
                      *cyc_cnt == 16 ? (8'd1) :
                      *cyc_cnt == 17 ? (-8'd2) :
                      *cyc_cnt == 18 ? (-8'd1) :
                      
                      
                      8'd0 :
                   *cyc_cnt == 1 ? (8'd0) :
                   8'd0;
                      
                      
      $yy_acc[7:0] = #ship == 2 ?  //blue
                      *cyc_cnt == 11 ? (-8'd2) :
                      *cyc_cnt == 12 ? (8'd2) : 
                      *cyc_cnt == 13 ? (8'd2) : 
                      *cyc_cnt == 14 ? (8'd1) :
                      *cyc_cnt == 15 ? (8'd0) :
                      *cyc_cnt == 16 ? (8'd0) :
                      *cyc_cnt == 17 ? (8'd0) :  
                      *cyc_cnt == 18 ? (8'd1) :   
                      *cyc_cnt == 19 ? (8'd3) :   
                      *cyc_cnt == 20 ? (8'd2) :
                      *cyc_cnt == 21 ? (8'd3) :
                      *cyc_cnt == 22 ? (8'd0) :  
                      *cyc_cnt == 23 ? (8'd2) :  
                      *cyc_cnt == 24 ? (8'd0) :  
                      *cyc_cnt == 25 ? (-8'd4) :
                      *cyc_cnt == 26 ? (-8'd4) :
                      *cyc_cnt == 27 ? (-8'd0) :  
                      *cyc_cnt == 28 ? (-8'd1) :
                      *cyc_cnt == 29 ? (-8'd3) : 
                      *cyc_cnt == 30 ? (-8'd2) :
                      *cyc_cnt == 31 ? (-8'd2) :
                      *cyc_cnt == 32 ? (8'd2) : //switch
                      *cyc_cnt == 33 ? (-8'd4) :
                      *cyc_cnt == 34 ? (-8'd3) :
                      *cyc_cnt == 35 ? (-8'd1) :
                      *cyc_cnt == 36 ? (-8'd0) :
                      *cyc_cnt == 37 ? (-8'd0) :
                      *cyc_cnt == 38 ? (8'd4) :
                      *cyc_cnt == 39 ? (8'd1) : //used to be 0
                      *cyc_cnt == 40 ? (8'd3) :
                      *cyc_cnt == 41 ? (8'd1) :
                      *cyc_cnt == 42 ? (8'd3) :
                      *cyc_cnt == 43 ? (-8'd2) :
                      *cyc_cnt == 44 ? (8'd2) :
                      *cyc_cnt == 45 ? (8'd3) :
                      *cyc_cnt == 46 ? (8'd3) :
                      *cyc_cnt == 47 ? (8'd4) : ///ADDED NEW FROM CHATGPT
                      *cyc_cnt == 47 ? (8'd4) :
                      *cyc_cnt == 48 ? (8'd4) :
                      *cyc_cnt == 49 ? (8'd3) :
                      *cyc_cnt == 50 ? (8'd3) :
                      *cyc_cnt == 51 ? (8'd4) : 
                      *cyc_cnt == 52 ? (8'd2) :
                      *cyc_cnt == 53 ? (8'd2) :
                      *cyc_cnt == 54 ? (-8'd4) :
                      *cyc_cnt == 55 ? (-8'd4) :
                      *cyc_cnt == 56 ? (-8'd3) :
                      *cyc_cnt == 57 ? (-8'd3) :
                      *cyc_cnt == 58 ? (8'd2) :
                      *cyc_cnt == 59 ? (-8'd2) :
                      *cyc_cnt == 60 ? (-8'd2) :
                      *cyc_cnt == 61 ? (-8'd2) :
                      *cyc_cnt == 62 ? (-8'd3) :
                      *cyc_cnt == 63 ? (-8'd3) :
                      *cyc_cnt == 64 ? (-8'd3) :
                      *cyc_cnt == 65 ? (-8'd2) :
                      *cyc_cnt == 66 ? (-8'd4) :
                      *cyc_cnt == 67 ? (-8'd3) :
                      *cyc_cnt == 68 ? (8'd4) :
                      *cyc_cnt == 69 ? (8'd4) :
                      *cyc_cnt == 70 ? (8'd4) :
                      *cyc_cnt == 71 ? (8'd3) :
                      *cyc_cnt == 72 ? (8'd2) :
                      *cyc_cnt == 73 ? (8'd3) :
                      *cyc_cnt == 74 ? (8'd4) :
                      *cyc_cnt == 75 ? (8'd3) :
                      *cyc_cnt == 76 ? (8'd2) :
                      *cyc_cnt == 77 ? (8'd2) :
                      *cyc_cnt == 78 ? (8'd2) :
                      *cyc_cnt == 79 ? (8'd2) :
                      *cyc_cnt == 80 ? (8'd2) :
                      *cyc_cnt == 81 ? (8'd2) :
                      *cyc_cnt == 82 ? (-8'd4) :
                      *cyc_cnt == 83 ? (-8'd4) :
                      *cyc_cnt == 84 ? (-8'd4) :
                      *cyc_cnt == 85 ? (-8'd4) :
                      *cyc_cnt == 86 ? (-8'd4) :
                      *cyc_cnt == 87 ? (-8'd4) :
                      *cyc_cnt == 88 ? (-8'd3) :
                      *cyc_cnt == 89 ? (-8'd4) :
                      *cyc_cnt == 90 ? (-8'd2) : //
                      *cyc_cnt == 91 ? (-8'd4) :
                      *cyc_cnt == 92 ? (-8'd3) :
                      *cyc_cnt == 93 ? (-8'd4) :
                      *cyc_cnt == 94 ? (-8'd4) :
                      *cyc_cnt == 95 ? (-8'd4) :
                      *cyc_cnt == 96 ? (8'd4) :
                      *cyc_cnt == 97 ? (8'd4) :
                      *cyc_cnt == 98 ? (8'd4) :
                      *cyc_cnt == 99 ? (8'd4) :
                      *cyc_cnt == 100 ? (8'd2) : //iukrftegfilkesg
                      *cyc_cnt == 101 ? (-8'd4):
                      *cyc_cnt == 102 ? (-8'd3) :   
                      *cyc_cnt == 103 ? (-8'd2) :   
                      *cyc_cnt == 104 ? (8'd4) :   
                      *cyc_cnt == 105 ? (8'd4) :
                      *cyc_cnt == 106 ? (8'd4) :   
                       *cyc_cnt == 107 ? (8'd4) :   
                       *cyc_cnt == 108 ? (-8'd4) :   
                       *cyc_cnt == 109 ? (-8'd4) :   
                       *cyc_cnt == 110 ? (-8'd4) :   
                       *cyc_cnt == 111 ? (-8'd1) :   
                       *cyc_cnt == 112 ? (-8'd3) :   
                       *cyc_cnt == 113 ? (-8'd0) :   
                       *cyc_cnt == 114 ? (-8'd0) :   
                       *cyc_cnt == 115 ? (-8'd0) :   
                       *cyc_cnt == 116 ? (-8'd0) :   
                       *cyc_cnt == 117 ? (8'd4) :   
                       *cyc_cnt == 118 ? (8'd3) :   
                       *cyc_cnt == 119 ? (8'd0) :   
                       *cyc_cnt == 120 ? (8'd0) :   
                       *cyc_cnt == 121 ? (8'd0) :   
                       *cyc_cnt == 122 ? (8'd4) :   
                       *cyc_cnt == 123 ? (8'd3) :   
                       *cyc_cnt == 124 ? (8'd1) :   
                       *cyc_cnt == 125 ? (8'd3) :   
                       *cyc_cnt == 126 ? (8'd4) :   
                       *cyc_cnt == 127 ? (8'd0) :   
                       *cyc_cnt == 128 ? (8'd0) :   
                       *cyc_cnt == 129 ? (8'd0) :   
                       *cyc_cnt == 130 ? (8'd0) :   
                       *cyc_cnt == 131 ? (8'd0) :   
                       *cyc_cnt == 132 ? (8'd3) :   
                       *cyc_cnt == 133 ? (8'd3) :   
                       *cyc_cnt == 134 ? (-8'd4) :   
                       *cyc_cnt == 135 ? (-8'd4) :   
                       *cyc_cnt == 136 ? (8'd2) :   
                       *cyc_cnt == 137 ? (-8'd4) :   
                       *cyc_cnt == 138 ? (-8'd2) :   
                       *cyc_cnt == 139 ? (-8'd3) :   
                       *cyc_cnt == 140 ? (-8'd3) :   
                       *cyc_cnt == 141 ? (-8'd2) :   
                       *cyc_cnt == 142 ? (-8'd2) :   
                       *cyc_cnt == 143 ? (-8'd2) :   
                       *cyc_cnt == 144 ? (-8'd2) :   
                       *cyc_cnt == 145 ? (-8'd3) :   
                       *cyc_cnt == 146 ? (-8'd3) :   
                       *cyc_cnt == 147 ? (-8'd3) :   
                       *cyc_cnt == 149 ? (8'd4) :
                       *cyc_cnt == 150 ? (8'd4) :
                       *cyc_cnt == 151 ? (8'd4) :
                       *cyc_cnt == 174 ? (-8'd4) :
                       *cyc_cnt == 175 ? (-8'd4) :
                       *cyc_cnt == 176 ? (-8'd4) :
                       *cyc_cnt == 186 ? (8'd4) :
                       *cyc_cnt == 187 ? (8'd4) :
                       *cyc_cnt == 188 ? (8'd4) :
                       *cyc_cnt == 200 ? (-8'd4) :
                       *cyc_cnt == 201 ? (-8'd4) :
                       *cyc_cnt == 202 ? (-8'd4) :
                       *cyc_cnt == 207 ? (8'd4) :
                       *cyc_cnt == 208 ? (8'd4) :
                       *cyc_cnt == 209 ? (8'd4) :
                       *cyc_cnt == 231 ? (-8'd4) :
                       *cyc_cnt == 232 ? (-8'd3) :
                       *cyc_cnt == 233 ? (-8'd2) :
                       *cyc_cnt == 140 ? (8'd4) :
                       *cyc_cnt == 141 ? (8'd4) :
                       *cyc_cnt == 142 ? (8'd4) :
                       *cyc_cnt == 143 ? (8'd4) :
                       *cyc_cnt == 250 ? (8'd4) :
                       *cyc_cnt == 251 ? (8'd4) :
                       *cyc_cnt == 252 ? (8'd4) :
                       *cyc_cnt == 262 ? (-8'd4) :
                       *cyc_cnt == 263 ? (-8'd4) :
                       *cyc_cnt == 264 ? (-8'd4) :
                       *cyc_cnt == 272 ? (8'd4) :
                       *cyc_cnt == 273 ? (8'd4) :
                       *cyc_cnt == 274 ? (8'd4) :
                       *cyc_cnt == 279 ? (-8'd4) :
                       *cyc_cnt == 280 ? (-8'd4) :
                       *cyc_cnt == 281 ? (-8'd4) :
                       *cyc_cnt == 295 ? (8'd4) :
                       *cyc_cnt == 296 ? (8'd4) :
                       *cyc_cnt == 297 ? (8'd4) :
                       *cyc_cnt == 307 ? (-8'd4) :
                       *cyc_cnt == 308 ? (-8'd4) :
                       *cyc_cnt == 309 ? (-8'd4) :
                       *cyc_cnt == 316 ? (8'd4) :
                       *cyc_cnt == 317 ? (8'd4) :
                       *cyc_cnt == 318 ? (8'd4) :
                       *cyc_cnt == 316 ? (8'd4) :
                       *cyc_cnt == 317 ? (8'd4) :
                       *cyc_cnt == 318 ? (8'd4) :
                       *cyc_cnt == 323 ? (-8'd4) :
                       *cyc_cnt == 324 ? (-8'd4) :
                       *cyc_cnt == 325 ? (-8'd4) :
                       *cyc_cnt == 333 ? (8'd4) :
                       *cyc_cnt == 334 ? (8'd4) :
                       *cyc_cnt == 335 ? (8'd4) :
                       *cyc_cnt == 340 ? (-8'd4) :
                       *cyc_cnt == 341 ? (-8'd4) :
                       *cyc_cnt == 342 ? (-8'd4) :
                       *cyc_cnt == 359 ? (8'd4) :
                       *cyc_cnt == 360 ? (8'd4) :
                       *cyc_cnt == 361 ? (8'd4) :
                       *cyc_cnt == 371 ? (-8'd4) :
                       *cyc_cnt == 372 ? (-8'd4) :
                       *cyc_cnt == 373 ? (-8'd4) :
                       *cyc_cnt == 383 ? (8'd4) :
                       *cyc_cnt == 384 ? (8'd4) :
                       *cyc_cnt == 385 ? (8'd4) :
                       *cyc_cnt == 393 ? (-8'd4) :
                       *cyc_cnt == 394 ? (-8'd4) :
                       *cyc_cnt == 395 ? (-8'd4) :
                       *cyc_cnt == 411 ? (8'd4) :
                       *cyc_cnt == 412 ? (8'd4) :
                       *cyc_cnt == 413? (8'd4) :
                       *cyc_cnt == 424 ? (-8'd4) :
                       *cyc_cnt == 425 ? (-8'd4) :
                       *cyc_cnt == 426? (-8'd4) :
                       *cyc_cnt == 441 ? (8'd4) :
                       *cyc_cnt == 442 ? (8'd4) :
                       *cyc_cnt == 443 ? (8'd4) :
                       *cyc_cnt == 454 ? (-8'd4) :
                       *cyc_cnt == 455 ? (-8'd4) :
                       *cyc_cnt == 456 ? (-8'd4) :
                       *cyc_cnt == 474 ? (8'd4) :
                       *cyc_cnt == 475 ? (8'd4) :
                       *cyc_cnt == 476 ? (8'd4) :
                       *cyc_cnt == 488 ? (-8'd4) :
                       *cyc_cnt == 489 ? (-8'd4) :
                       *cyc_cnt == 490? (-8'd4) :
                       *cyc_cnt == 507 ? (8'd4) :
                       *cyc_cnt == 508 ? (8'd4) :
                       *cyc_cnt == 509 ? (8'd4) :
                       *cyc_cnt == 519 ? (-8'd4) :
                       *cyc_cnt == 520 ? (-8'd4) :
                       *cyc_cnt == 521 ? (-8'd4) :
                       *cyc_cnt == 537 ? (8'd4) :
                       *cyc_cnt == 538 ? (8'd4) :
                       *cyc_cnt == 539? (8'd4) :
                       *cyc_cnt == 551 ? (-8'd4) :
                       *cyc_cnt == 552 ? (-8'd4) :
                       *cyc_cnt == 553? (-8'd4) :
                       *cyc_cnt == 569 ? (8'd4) :
                       *cyc_cnt == 570 ? (8'd4) :
                       *cyc_cnt == 571 ? (8'd4) :
                       *cyc_cnt == 582 ? (-8'd4) :
                       *cyc_cnt == 583 ? (-8'd4) :
                       *cyc_cnt == 584 ? (-8'd4) :
                       
                       
                       
                       
                     
                      8'd0 :
                   *cyc_cnt == 1 ? (8'd0) :
                   8'd0;
                   
      $yy_acc[7:0] = #ship == 1 ? //green
                      *cyc_cnt == 1 ? (-8'd4) : //go to starting position
                      *cyc_cnt == 2 ? (-8'd4) :
                      *cyc_cnt == 3 ? (-8'd1) :
                      *cyc_cnt == 4 ? (8'd0) :
                      *cyc_cnt == 5 ? (-8'd1) :
                      *cyc_cnt == 6 ? (8'd0) :
                      *cyc_cnt == 7 ? (8'd0) :
                      *cyc_cnt == 8 ? (8'd2) :
                      *cyc_cnt == 9 ? (8'd2) :
                      *cyc_cnt == 10 ? (8'd2) : //starting position end
                      *cyc_cnt == 11 ? (-8'd2) :
                      *cyc_cnt == 12 ? (8'd4) : 
                      *cyc_cnt == 13 ? (8'd3) : 
                      *cyc_cnt == 14 ? (8'd1) :
                      *cyc_cnt == 15 ? (8'd0) :
                      *cyc_cnt == 16 ? (8'd0) :
                      *cyc_cnt == 17 ? (8'd0) :  
                      *cyc_cnt == 18 ? (8'd1) :   
                      *cyc_cnt == 19 ? (8'd3) :   
                      *cyc_cnt == 20 ? (8'd2) :
                      *cyc_cnt == 21 ? (8'd4) :
                      *cyc_cnt == 22 ? (8'd0) :  
                      *cyc_cnt == 23 ? (8'd4) :  
                      *cyc_cnt == 24 ? (8'd0) :  
                      *cyc_cnt == 25 ? (8'd4) :
                      *cyc_cnt == 26 ? (-8'd4) :
                      *cyc_cnt == 27 ? (-8'd0) :  
                      *cyc_cnt == 28 ? (-8'd1) :
                      *cyc_cnt == 29 ? (-8'd3) : 
                      *cyc_cnt == 30 ? (-8'd2) :
                      *cyc_cnt == 31 ? (-8'd2) :
                      *cyc_cnt == 32 ? (8'd2) : //switch
                      *cyc_cnt == 33 ? (-8'd4) :
                      *cyc_cnt == 34 ? (-8'd3) :
                      *cyc_cnt == 35 ? (-8'd1) :
                      *cyc_cnt == 36 ? (-8'd0) :
                      *cyc_cnt == 37 ? (-8'd0) :
                      *cyc_cnt == 38 ? (-8'd0) :
                      *cyc_cnt == 39 ? (-8'd1) : //used to be 0
                      *cyc_cnt == 40 ? (-8'd3) :
                      *cyc_cnt == 41 ? (-8'd1) :
                      *cyc_cnt == 42 ? (-8'd3) :
                      *cyc_cnt == 43 ? (-8'd4) :
                      *cyc_cnt == 44 ? (-8'd4) :
                      *cyc_cnt == 45 ? (8'd3) :
                      *cyc_cnt == 46 ? (8'd3) :
                      *cyc_cnt == 47 ? (8'd4) : ///ADDED NEW FROM CHATGPT
                      *cyc_cnt == 47 ? (8'd4) :
                      *cyc_cnt == 48 ? (8'd4) :
                      *cyc_cnt == 49 ? (8'd3) :
                      *cyc_cnt == 50 ? (8'd3) :
                      *cyc_cnt == 51 ? (8'd4) : 
                      *cyc_cnt == 52 ? (8'd2) :
                      *cyc_cnt == 53 ? (8'd2) :
                      *cyc_cnt == 54 ? (8'd2) :
                      *cyc_cnt == 55 ? (8'd2) :
                      *cyc_cnt == 56 ? (8'd3) :
                      *cyc_cnt == 57 ? (8'd3) :
                      *cyc_cnt == 58 ? (8'd2) :
                      *cyc_cnt == 59 ? (-8'd2) :
                      *cyc_cnt == 60 ? (-8'd2) :
                      *cyc_cnt == 61 ? (-8'd2) :
                      *cyc_cnt == 62 ? (-8'd3) :
                      *cyc_cnt == 63 ? (-8'd3) :
                      *cyc_cnt == 64 ? (-8'd3) :
                      *cyc_cnt == 65 ? (-8'd2) :
                      *cyc_cnt == 66 ? (-8'd4) :
                      *cyc_cnt == 67 ? (-8'd3) :
                      *cyc_cnt == 68 ? (-8'd2) :
                      *cyc_cnt == 69 ? (-8'd2) :
                      *cyc_cnt == 70 ? (-8'd4) :
                      *cyc_cnt == 71 ? (-8'd3) :
                      *cyc_cnt == 72 ? (-8'd2) :
                      *cyc_cnt == 73 ? (-8'd3) :
                      *cyc_cnt == 74 ? (8'd4) :
                      *cyc_cnt == 75 ? (8'd3) :
                      *cyc_cnt == 76 ? (8'd2) :
                      *cyc_cnt == 77 ? (8'd2) :
                      *cyc_cnt == 78 ? (8'd2) :
                      *cyc_cnt == 79 ? (8'd2) :
                      *cyc_cnt == 80 ? (8'd2) :
                      *cyc_cnt == 81 ? (8'd2) :
                      *cyc_cnt == 82 ? (8'd2) :
                      *cyc_cnt == 83 ? (8'd2) :
                      *cyc_cnt == 84 ? (8'd3) :
                      *cyc_cnt == 85 ? (8'd4) :
                      *cyc_cnt == 86 ? (8'd4) :
                      *cyc_cnt == 87 ? (8'd4) :
                      *cyc_cnt == 88 ? (8'd3) :
                      *cyc_cnt == 89 ? (-8'd4) :
                      *cyc_cnt == 90 ? (-8'd2) : //
                      *cyc_cnt == 91 ? (-8'd4) :
                      *cyc_cnt == 92 ? (-8'd3) :
                      *cyc_cnt == 93 ? (-8'd4) :
                      *cyc_cnt == 94 ? (-8'd4) :
                      *cyc_cnt == 95 ? (-8'd4) :
                      *cyc_cnt == 96 ? (-8'd4) :
                      *cyc_cnt == 97 ? (-8'd4) :
                      *cyc_cnt == 98 ? (8'd3) :
                      *cyc_cnt == 99 ? (-8'd4) :
                      *cyc_cnt == 100 ? (-8'd2) : //test
                       *cyc_cnt == 101 ? (-8'd1) :   
                       *cyc_cnt == 102 ? (-8'd3) :   
                       *cyc_cnt == 103 ? (-8'd2) :   
                       *cyc_cnt == 104 ? (8'd4) :   
                       *cyc_cnt == 105 ? (8'd4) :   
                       *cyc_cnt == 106 ? (8'd4) :   
                       *cyc_cnt == 107 ? (8'd4) :   
                       *cyc_cnt == 108 ? (8'd4) :   
                       *cyc_cnt == 109 ? (8'd0) :   
                       *cyc_cnt == 110 ? (8'd0) :   
                       *cyc_cnt == 111 ? (8'd1) :   
                       *cyc_cnt == 112 ? (8'd3) :   
                       *cyc_cnt == 113 ? (8'd4) :   
                       *cyc_cnt == 114 ? (8'd4) :   
                       *cyc_cnt == 115 ? (8'd3) :   
                       *cyc_cnt == 116 ? (-8'd4) :   
                       *cyc_cnt == 117 ? (-8'd3) :   
                       *cyc_cnt == 118 ? (-8'd1) :   
                       *cyc_cnt == 119 ? (-8'd0) :   
                       *cyc_cnt == 120 ? (-8'd0) :   
                       *cyc_cnt == 121 ? (-8'd0) :   
                       *cyc_cnt == 122 ? (-8'd1) :   
                       *cyc_cnt == 123 ? (-8'd3) :   
                       *cyc_cnt == 124 ? (-8'd1) :   
                       *cyc_cnt == 125 ? (-8'd3) :   
                       *cyc_cnt == 126 ? (-8'd4) :   
                       *cyc_cnt == 127 ? (-8'd4) :   
                       *cyc_cnt == 128 ? (-8'd3) :   
                       *cyc_cnt == 129 ? (-8'd3) :   
                       *cyc_cnt == 130 ? (-8'd4) :   
                       *cyc_cnt == 131 ? (-8'd4) :   
                       *cyc_cnt == 132 ? (-8'd3) :   
                       *cyc_cnt == 133 ? (8'd3) :   
                       *cyc_cnt == 134 ? (8'd4) :   
                       *cyc_cnt == 135 ? (8'd2) :   
                       *cyc_cnt == 136 ? (8'd2) :   
                       *cyc_cnt == 137 ? (8'd2) :   
                       *cyc_cnt == 138 ? (8'd2) :   
                       *cyc_cnt == 139 ? (8'd3) :   
                       *cyc_cnt == 140 ? (8'd3) :   
                       *cyc_cnt == 141 ? (8'd2) :   
                       *cyc_cnt == 142 ? (8'd2) :   
                       *cyc_cnt == 143 ? (8'd2) :   
                       *cyc_cnt == 144 ? (8'd2) :   
                       *cyc_cnt == 145 ? (8'd3) :   
                       *cyc_cnt == 146 ? (8'd3) :   
                       *cyc_cnt == 147 ? (8'd3) :   
                       *cyc_cnt == 148 ? (8'd2) :   
                       *cyc_cnt == 149 ? (-8'd4) :   
                       *cyc_cnt == 150 ? (-8'd3) :   
                       *cyc_cnt == 151 ? (-8'd2) :   
                       *cyc_cnt == 152 ? (-8'd2) :   
                       *cyc_cnt == 153 ? (-8'd4) :   
                       *cyc_cnt == 154 ? (-8'd3) :   
                       *cyc_cnt == 155 ? (-8'd2) :   
                       *cyc_cnt == 156 ? (-8'd3) :   
                       *cyc_cnt == 157 ? (-8'd4) :   
                       *cyc_cnt == 158 ? (-8'd3) :   
                       *cyc_cnt == 159 ? (-8'd2) :   
                       *cyc_cnt == 160 ? (-8'd2) :   
                       *cyc_cnt == 161 ? (-8'd2) :   
                       *cyc_cnt == 162 ? (-8'd2) :   
                       *cyc_cnt == 163 ? (-8'd2) :   
                       *cyc_cnt == 164 ? (-8'd2) :   
                       *cyc_cnt == 165 ? (8'd2) :   
                       *cyc_cnt == 166 ? (8'd2) :   
                       *cyc_cnt == 167 ? (8'd3) :   
                       *cyc_cnt == 168 ? (8'd4) :   
                       *cyc_cnt == 169 ? (8'd4) :   
                       *cyc_cnt == 170 ? (8'd4) :   
                       *cyc_cnt == 171 ? (8'd3) :   
                       *cyc_cnt == 172 ? (8'd4) :   
                       *cyc_cnt == 173 ? (8'd2) :   
                       *cyc_cnt == 174 ? (8'd4) :   
                       *cyc_cnt == 175 ? (8'd3) :   
                       *cyc_cnt == 176 ? (8'd4) :   
                       *cyc_cnt == 177 ? (8'd4) :   
                       *cyc_cnt == 178 ? (8'd4) :   
                       *cyc_cnt == 179 ? (8'd4) :   
                       *cyc_cnt == 180 ? (-8'd4) :   
                       *cyc_cnt == 181 ? (-8'd3) :   
                       *cyc_cnt == 182 ? (-8'd4) :   
                       *cyc_cnt == 183 ? (-8'd2) :   
                       *cyc_cnt == 184 ? (-8'd1) :   
                       *cyc_cnt == 185 ? (-8'd3) :   
                       *cyc_cnt == 186 ? (-8'd2) :   
                       *cyc_cnt == 187 ? (-8'd4) :   
                       *cyc_cnt == 188 ? (-8'd0) :   
                       *cyc_cnt == 189 ? (-8'd4) :   
                       *cyc_cnt == 190 ? (-8'd0) :   
                       *cyc_cnt == 191 ? (-8'd4) :   
                       *cyc_cnt == 192 ? (8'd4) :   
                       *cyc_cnt == 193 ? (8'd0) :   
                       *cyc_cnt == 194 ? (8'd1) :   
                       *cyc_cnt == 195 ? (8'd3) :   
                       *cyc_cnt == 196 ? (8'd2) :   
                       *cyc_cnt == 197 ? (8'd2) :   
                       *cyc_cnt == 198 ? (8'd2) :   
                       *cyc_cnt == 199 ? (8'd4) :   
                       *cyc_cnt == 200 ? (8'd3) :   
                       *cyc_cnt == 201 ? (8'd1) :   
                       *cyc_cnt == 202 ? (8'd0) :   
                       *cyc_cnt == 203 ? (8'd0) :   
                       *cyc_cnt == 204 ? (8'd0) :   
                       *cyc_cnt == 205 ? (8'd1) :   
                       *cyc_cnt == 206 ? (8'd3) :   
                       *cyc_cnt == 207 ? (8'd1) :   
                       *cyc_cnt == 208 ? (-8'd3) :   
                       *cyc_cnt == 209 ? (-8'd4) :   
                       *cyc_cnt == 210 ? (-8'd4) :   
                       *cyc_cnt == 211 ? (-8'd3) :   
                       *cyc_cnt == 212 ? (-8'd3) :   
                       *cyc_cnt == 213 ? (-8'd4) :   
                       *cyc_cnt == 214 ? (-8'd4) :   
                       *cyc_cnt == 215 ? (-8'd3) :   
                       *cyc_cnt == 216 ? (-8'd3) :   
                       *cyc_cnt == 217 ? (-8'd4) :   
                       *cyc_cnt == 218 ? (-8'd2) :   
                       *cyc_cnt == 219 ? (-8'd2) :   
                       *cyc_cnt == 220 ? (-8'd2) :   
                       *cyc_cnt == 221 ? (8'd2) :   
                       *cyc_cnt == 222 ? (8'd3) :   
                       *cyc_cnt == 223 ? (8'd3) :   
                       *cyc_cnt == 224 ? (8'd2) :   
                       *cyc_cnt == 225 ? (8'd2) :   
                       *cyc_cnt == 226 ? (8'd2) :   
                       *cyc_cnt == 227 ? (8'd2) :   
                       *cyc_cnt == 228 ? (8'd3) :   
                       *cyc_cnt == 229 ? (8'd3) :   
                       *cyc_cnt == 230 ? (8'd3) :   
                       *cyc_cnt == 231 ? (8'd2) :   
                       *cyc_cnt == 232 ? (8'd4) :   
                       *cyc_cnt == 233 ? (8'd3) :   
                       *cyc_cnt == 234 ? (-8'd4) :   
                       *cyc_cnt == 235 ? (-8'd2) :   
                       *cyc_cnt == 236 ? (-8'd4) :   
                       *cyc_cnt == 237 ? (-8'd3) :   
                       *cyc_cnt == 238 ? (-8'd2) :   
                       *cyc_cnt == 239 ? (-8'd3) :   
                       *cyc_cnt == 240 ? (-8'd4) :   
                       *cyc_cnt == 241 ? (-8'd3) :   
                       *cyc_cnt == 242 ? (-8'd2) :   
                       *cyc_cnt == 243 ? (-8'd2) :   
                       *cyc_cnt == 244 ? (-8'd2) :   
                       *cyc_cnt == 245 ? (-8'd2) :   
                       *cyc_cnt == 246 ? (-8'd2) :   
                       *cyc_cnt == 247 ? (8'd4) :   
                       *cyc_cnt == 248 ? (8'd2) :   
                       *cyc_cnt == 249 ? (8'd2) :   
                       *cyc_cnt == 250 ? (8'd3) :   
                       *cyc_cnt == 251 ? (8'd4) :   
                       *cyc_cnt == 252 ? (8'd4) :   
                       *cyc_cnt == 253 ? (8'd4) :   
                       *cyc_cnt == 254 ? (8'd3) :   
                       *cyc_cnt == 255 ? (8'd4) :   
                       *cyc_cnt == 256 ? (8'd2) :   
                       *cyc_cnt == 257 ? (8'd4) :   
                       *cyc_cnt == 258 ? (-8'd3) :   
                       *cyc_cnt == 259 ? (-8'd4) :   
                       *cyc_cnt == 260 ? (-8'd4) :   
                       *cyc_cnt == 261 ? (-8'd4) :   
                       *cyc_cnt == 262 ? (-8'd4) :   
                       *cyc_cnt == 263 ? (-8'd4) :   
                       *cyc_cnt == 264 ? (-8'd3) :   
                       *cyc_cnt == 265 ? (-8'd4) :   
                       *cyc_cnt == 266 ? (-8'd2) :   
                       *cyc_cnt == 267 ? (8'd1) :   
                       *cyc_cnt == 268 ? (8'd3) :   
                       *cyc_cnt == 269 ? (8'd2) :   
                       *cyc_cnt == 270 ? (8'd4) :   
                       *cyc_cnt == 271 ? (8'd0) :   
                       *cyc_cnt == 272 ? (8'd4) :   
                       *cyc_cnt == 273 ? (8'd0) :   
                       *cyc_cnt == 274 ? (8'd4) :   
                       *cyc_cnt == 275 ? (-8'd4) :   
                       *cyc_cnt == 276 ? (-8'd0) :   
                       *cyc_cnt == 277 ? (-8'd1) :   
                       *cyc_cnt == 278 ? (-8'd3) :   
                       *cyc_cnt == 279 ? (-8'd2) :   
                       *cyc_cnt == 280 ? (-8'd2) :   
                       *cyc_cnt == 281 ? (8'd2) :   
                       *cyc_cnt == 282 ? (-8'd4) :   
                       *cyc_cnt == 283 ? (8'd3) :   
                       *cyc_cnt == 284 ? (8'd1) :   
                       *cyc_cnt == 285 ? (8'd4) :   
                       *cyc_cnt == 286 ? (8'd0) :   
                       *cyc_cnt == 287 ? (8'd0) :   
                       *cyc_cnt == 288 ? (8'd1) :   
                       *cyc_cnt == 289 ? (8'd3) :   
                       *cyc_cnt == 290 ? (8'd1) :   
                       *cyc_cnt == 291 ? (8'd3) :   
                       *cyc_cnt == 292 ? (8'd4) :   
                       *cyc_cnt == 293 ? (8'd4) :   
                       *cyc_cnt == 294 ? (8'd3) :   
                       *cyc_cnt == 295 ? (8'd3) :   
                       *cyc_cnt == 296 ? (-8'd4) :   
                       *cyc_cnt == 297 ? (-8'd4) :   
                       *cyc_cnt == 298 ? (-8'd3) :   
                       *cyc_cnt == 299 ? (-8'd3) :   
                       *cyc_cnt == 300 ? (-8'd4) :   
                       *cyc_cnt == 301 ? (-8'd2) :   
                       *cyc_cnt == 302 ? (-8'd2) :   
                       *cyc_cnt == 303 ? (-8'd2) :   
                       *cyc_cnt == 304 ? (-8'd2) :   
                       *cyc_cnt == 305 ? (-8'd3) :   
                       *cyc_cnt == 306 ? (-8'd3) :   
                       *cyc_cnt == 307 ? (-8'd2) :   
                       *cyc_cnt == 308 ? (8'd4) :   
                       *cyc_cnt == 309 ? (8'd2) :   
                       *cyc_cnt == 310 ? (8'd2) :   
                       *cyc_cnt == 311 ? (8'd3) :   
                       *cyc_cnt == 312 ? (8'd3) :   
                       *cyc_cnt == 313 ? (-8'd3) :   
                       *cyc_cnt == 314 ? (-8'd2) :   
                       *cyc_cnt == 315 ? (8'd4) :   
                       *cyc_cnt == 316 ? (8'd3) :   
                       *cyc_cnt == 317 ? (8'd2) :   
                       *cyc_cnt == 318 ? (8'd2) :   
                       *cyc_cnt == 319 ? (8'd4) :   
                       *cyc_cnt == 320 ? (8'd3) :   
                       *cyc_cnt == 321 ? (8'd2) :   
                       *cyc_cnt == 322 ? (8'd3) :   
                       *cyc_cnt == 323 ? (-8'd4) :   
                       *cyc_cnt == 324 ? (-8'd3) :   
                       *cyc_cnt == 325 ? (-8'd2) :   
                       *cyc_cnt == 326 ? (-8'd2) :   
                       *cyc_cnt == 327 ? (-8'd4) :   
                       *cyc_cnt == 328 ? (-8'd2) :   
                       *cyc_cnt == 329 ? (-8'd2) :   
                       *cyc_cnt == 330 ? (-8'd2) :   
                       *cyc_cnt == 331 ? (-8'd2) :   
                       *cyc_cnt == 332 ? (-8'd2) :   
                       *cyc_cnt == 333 ? (-8'd3) :   
                       *cyc_cnt == 334 ? (-8'd4) :   
                       *cyc_cnt == 335 ? (-8'd4) :   
                       *cyc_cnt == 336 ? (8'd4) :   
                       *cyc_cnt == 337 ? (8'd3) :   
                       *cyc_cnt == 338 ? (8'd3) :   
                       *cyc_cnt == 339 ? (8'd3) :   
                       *cyc_cnt == 340 ? (8'd4) :   
                       *cyc_cnt == 341 ? (8'd3) :   
                       *cyc_cnt == 342 ? (8'd4) :   
                       *cyc_cnt == 343 ? (8'd4) :   
                       *cyc_cnt == 344 ? (8'd4) :   
                       *cyc_cnt == 345 ? (-8'd4) :   
                       *cyc_cnt == 346 ? (-8'd4) :   
                       *cyc_cnt == 347 ? (-8'd3) :   
                       *cyc_cnt == 348 ? (-8'd4) :   
                       *cyc_cnt == 349 ? (-8'd2) :   
                       *cyc_cnt == 350 ? (-8'd1) :   
                       *cyc_cnt == 351 ? (-8'd3) :   
                       *cyc_cnt == 352 ? (-8'd2) :   
                       *cyc_cnt == 353 ? (8'd4) :   
                       *cyc_cnt == 354 ? (8'd0) :   
                       *cyc_cnt == 355 ? (8'd4) :   
                       *cyc_cnt == 356 ? (8'd0) :   
                       *cyc_cnt == 357 ? (8'd4) :   
                       *cyc_cnt == 358 ? (8'd4) :   
                       *cyc_cnt == 359 ? (8'd0) :   
                       *cyc_cnt == 360 ? (8'd1) :   
                       *cyc_cnt == 361 ? (8'd3) :   
                       *cyc_cnt == 362 ? (8'd2) :   
                       *cyc_cnt == 363 ? (-8'd2) :   
                       *cyc_cnt == 364 ? (-8'd2) :   
                       *cyc_cnt == 365 ? (-8'd4) :   
                       *cyc_cnt == 366 ? (-8'd3) :   
                       *cyc_cnt == 367 ? (-8'd1) :   
                       *cyc_cnt == 368 ? (-8'd0) :   
                       *cyc_cnt == 369 ? (-8'd0) :   
                       *cyc_cnt == 370 ? (-8'd0) :   
                       *cyc_cnt == 371 ? (-8'd1) :   
                       *cyc_cnt == 372 ? (-8'd3) :   
                       *cyc_cnt == 373 ? (-8'd1) :   
                       *cyc_cnt == 374 ? (-8'd3) :   
                       *cyc_cnt == 375 ? (-8'd4) :   
                       *cyc_cnt == 376 ? (-8'd4) :   
                       *cyc_cnt == 377 ? (8'd3) :   
                       *cyc_cnt == 378 ? (8'd3) :   
                       *cyc_cnt == 379 ? (8'd4) :   
                       *cyc_cnt == 380 ? (8'd4) :   
                       *cyc_cnt == 381 ? (8'd3) :   
                       *cyc_cnt == 382 ? (8'd3) :   
                       *cyc_cnt == 383 ? (8'd4) :   
                       *cyc_cnt == 384 ? (8'd2) :   
                       *cyc_cnt == 385 ? (8'd2) :   
                       *cyc_cnt == 386 ? (8'd2) :   
                       *cyc_cnt == 387 ? (8'd2) :   
                       *cyc_cnt == 388 ? (8'd3) :   
                       *cyc_cnt == 389 ? (8'd3) :   
                       *cyc_cnt == 390 ? (8'd2) :   
                       *cyc_cnt == 391 ? (-8'd2) :   
                       *cyc_cnt == 392 ? (-8'd2) :   
                       *cyc_cnt == 393 ? (-8'd2) :   
                       *cyc_cnt == 394 ? (-8'd3) :   
                       *cyc_cnt == 395 ? (-8'd3) :   
                       *cyc_cnt == 396 ? (-8'd3) :   
                       *cyc_cnt == 397 ? (-8'd2) :   
                       *cyc_cnt == 398 ? (-8'd4) :   
                       *cyc_cnt == 399 ? (-8'd3) :   
                       *cyc_cnt == 400 ? (-8'd2) :   
                       *cyc_cnt == 401 ? (-8'd2) :   
                       *cyc_cnt == 402 ? (-8'd4) :   
                       *cyc_cnt == 403 ? (-8'd3) :   
                       *cyc_cnt == 404 ? (-8'd2) :   
                       *cyc_cnt == 405 ? (-8'd3) :   
                       *cyc_cnt == 406 ? (8'd4) :   
                       *cyc_cnt == 407 ? (8'd3) :   
                       *cyc_cnt == 408 ? (8'd2) :   
                       *cyc_cnt == 409 ? (8'd2) :   
                       *cyc_cnt == 410 ? (8'd2) :   
                       *cyc_cnt == 411 ? (8'd2) :   
                       *cyc_cnt == 412 ? (8'd2) :   
                       *cyc_cnt == 413 ? (8'd2) :   
                       *cyc_cnt == 414 ? (8'd2) :   
                       *cyc_cnt == 415 ? (8'd2) :   
                       *cyc_cnt == 416 ? (8'd3) :   
                       *cyc_cnt == 417 ? (8'd4) :   
                       *cyc_cnt == 418 ? (8'd4) :   
                       *cyc_cnt == 419 ? (8'd4) :   
                       *cyc_cnt == 420 ? (8'd3) :   
                       *cyc_cnt == 421 ? (-8'd4) :   
                       *cyc_cnt == 422 ? (-8'd2) :   
                       *cyc_cnt == 423 ? (-8'd4) :   
                       *cyc_cnt == 424 ? (-8'd3) :   
                       *cyc_cnt == 425 ? (-8'd4) :   
                       *cyc_cnt == 426 ? (-8'd4) :   
                       *cyc_cnt == 427 ? (-8'd4) :   
                       *cyc_cnt == 428 ? (-8'd4) :   
                       *cyc_cnt == 429 ? (-8'd4) :   
                       *cyc_cnt == 430 ? (8'd3) :   
                       *cyc_cnt == 431 ? (8'd4) :   
                       *cyc_cnt == 432 ? (8'd2) :   
                       *cyc_cnt == 433 ? (8'd1) :   
                       *cyc_cnt == 434 ? (8'd3) :   
                       *cyc_cnt == 435 ? (8'd2) :   
                       *cyc_cnt == 436 ? (8'd4) :   
                       *cyc_cnt == 437 ? (8'd0) :   
                       *cyc_cnt == 438 ? (8'd4) :   
                       *cyc_cnt == 439 ? (8'd0) :   
                       *cyc_cnt == 440 ? (8'd4) :   
                       *cyc_cnt == 441 ? (-8'd4) :   
                       *cyc_cnt == 442 ? (-8'd0) :   
                       *cyc_cnt == 443 ? (-8'd1) :   
                       *cyc_cnt == 444 ? (-8'd3) :   
                       *cyc_cnt == 445 ? (-8'd2) :   
                       *cyc_cnt == 446 ? (-8'd2) :   
                       *cyc_cnt == 447 ? (8'd2) :   
                       *cyc_cnt == 448 ? (-8'd4) :   
                       *cyc_cnt == 449 ? (-8'd3) :   
                       *cyc_cnt == 450 ? (-8'd1) :   
                       *cyc_cnt == 451 ? (-8'd0) :   
                       *cyc_cnt == 452 ? (-8'd0) :   
                       *cyc_cnt == 453 ? (-8'd0) :   
                       *cyc_cnt == 454 ? (-8'd1) :   
                       *cyc_cnt == 455 ? (-8'd3) :   
                       *cyc_cnt == 456 ? (-8'd1) :   
                       *cyc_cnt == 457 ? (-8'd3) :   
                       *cyc_cnt == 458 ? (-8'd4) :   
                       *cyc_cnt == 459 ? (-8'd4) :   
                       *cyc_cnt == 460 ? (8'd3) :   
                       *cyc_cnt == 461 ? (8'd3) :   
                       *cyc_cnt == 462 ? (8'd4) :   
                       *cyc_cnt == 463 ? (8'd4) :   
                       *cyc_cnt == 464 ? (8'd3) :   
                       *cyc_cnt == 465 ? (8'd3) :   
                       *cyc_cnt == 466 ? (8'd4) :   
                       *cyc_cnt == 467 ? (8'd2) :   
                       *cyc_cnt == 468 ? (8'd2) :   
                       *cyc_cnt == 469 ? (8'd2) :   
                       *cyc_cnt == 470 ? (8'd2) :   
                       *cyc_cnt == 471 ? (8'd3) :   
                       *cyc_cnt == 472 ? (8'd3) :   
                       *cyc_cnt == 473 ? (8'd2) :   
                       *cyc_cnt == 474 ? (-8'd2) :   
                       *cyc_cnt == 475 ? (-8'd2) :   
                       *cyc_cnt == 476 ? (-8'd2) :   
                       *cyc_cnt == 477 ? (-8'd3) :   
                       *cyc_cnt == 478 ? (-8'd3) :   
                       *cyc_cnt == 479 ? (-8'd3) :   
                       *cyc_cnt == 480 ? (-8'd2) :   
                       *cyc_cnt == 481 ? (-8'd4) :   
                       *cyc_cnt == 482 ? (-8'd3) :   
                       *cyc_cnt == 483 ? (-8'd2) :   
                       *cyc_cnt == 484 ? (-8'd2) :   
                       *cyc_cnt == 485 ? (-8'd4) :   
                       *cyc_cnt == 486 ? (-8'd3) :   
                       *cyc_cnt == 487 ? (-8'd2) :   
                       *cyc_cnt == 488 ? (-8'd3) :   
                       *cyc_cnt == 489 ? (8'd4) :   
                       *cyc_cnt == 490 ? (8'd3) :   
                       *cyc_cnt == 491 ? (8'd2) :   
                       *cyc_cnt == 492 ? (8'd2) :   
                       *cyc_cnt == 493 ? (8'd2) :   
                       *cyc_cnt == 495 ? (8'd2) :   
                       *cyc_cnt == 496 ? (8'd2) :   
                       *cyc_cnt == 497 ? (8'd2) :   
                       *cyc_cnt == 498 ? (8'd2) :   
                       *cyc_cnt == 499 ? (8'd3) :   
                       *cyc_cnt == 500 ? (8'd4) :   
                       *cyc_cnt == 501 ? (8'd4) :   
                       *cyc_cnt == 502 ? (8'd4) :   
                       *cyc_cnt == 503 ? (8'd3) :   
                       *cyc_cnt == 504 ? (-8'd4) :   
                       *cyc_cnt == 505 ? (-8'd2) :   
                       *cyc_cnt == 506 ? (-8'd4) :   
                       *cyc_cnt == 507 ? (-8'd3) :   
                       *cyc_cnt == 508 ? (-8'd4) :   
                       *cyc_cnt == 509 ? (-8'd4) :   
                       *cyc_cnt == 510 ? (-8'd4) :   
                       *cyc_cnt == 511 ? (-8'd4) :   
                       *cyc_cnt == 512 ? (-8'd4) :   
                       *cyc_cnt == 513 ? (8'd3) :   
                       *cyc_cnt == 514 ? (8'd4) :   
                       *cyc_cnt == 515 ? (8'd2) :   
                       *cyc_cnt == 516 ? (8'd1) :   
                       *cyc_cnt == 517 ? (8'd3) :   
                       *cyc_cnt == 518 ? (8'd2) :   
                       *cyc_cnt == 519 ? (8'd4) :   
                       *cyc_cnt == 520 ? (8'd0) :   
                       *cyc_cnt == 521 ? (-8'd4) :   
                       *cyc_cnt == 522 ? (-8'd0) :   
                       *cyc_cnt == 523 ? (-8'd4) :   
                       *cyc_cnt == 524 ? (-8'd4) :   
                       *cyc_cnt == 525 ? (-8'd0) :   
                       *cyc_cnt == 526 ? (-8'd1) :   
                       *cyc_cnt == 527 ? (-8'd3) :   
                       *cyc_cnt == 528 ? (-8'd2) :   
                       *cyc_cnt == 529 ? (-8'd2) :   
                       *cyc_cnt == 530 ? (8'd2) :   
                       *cyc_cnt == 531 ? (-8'd4) :   
                       *cyc_cnt == 532 ? (-8'd3) :   
                       *cyc_cnt == 533 ? (-8'd1) :   
                       *cyc_cnt == 534 ? (8'd4) :   
                       *cyc_cnt == 535 ? (8'd3) :   
                       *cyc_cnt == 536 ? (8'd0) :   
                       *cyc_cnt == 537 ? (8'd1) :   
                       *cyc_cnt == 538 ? (8'd3) :   
                       *cyc_cnt == 539 ? (8'd1) :   
                       *cyc_cnt == 540 ? (8'd3) :   
                       *cyc_cnt == 541 ? (8'd4) :   
                       *cyc_cnt == 542 ? (8'd4) :   
                       *cyc_cnt == 543 ? (8'd3) :   
                       *cyc_cnt == 544 ? (8'd3) :   
                       *cyc_cnt == 545 ? (8'd4) :   
                       *cyc_cnt == 546 ? (8'd4) :   
                       *cyc_cnt == 547 ? (-8'd3) :   
                       *cyc_cnt == 548 ? (-8'd3) :   
                       *cyc_cnt == 549 ? (-8'd4) :   
                       *cyc_cnt == 550 ? (-8'd2) :   
                       *cyc_cnt == 551 ? (-8'd2) :   
                       *cyc_cnt == 552 ? (-8'd2) :   
                       *cyc_cnt == 553 ? (-8'd2) :   
                       *cyc_cnt == 554 ? (-8'd3) :   
                       *cyc_cnt == 555 ? (-8'd3) :   
                       *cyc_cnt == 556 ? (-8'd2) :   
                       *cyc_cnt == 557 ? (-8'd4) :   
                       *cyc_cnt == 558 ? (8'd4) :   
                       *cyc_cnt == 559 ? (8'd2) :   
                       *cyc_cnt == 560 ? (8'd3) :   
                       *cyc_cnt == 561 ? (8'd3) :   
                       *cyc_cnt == 562 ? (8'd3) :   
                       *cyc_cnt == 563 ? (8'd2) :   
                       *cyc_cnt == 564 ? (8'd4) :   
                       *cyc_cnt == 565 ? (8'd3) :   
                       *cyc_cnt == 566 ? (8'd2) :   
                       *cyc_cnt == 567 ? (8'd2) :   
                       *cyc_cnt == 568 ? (8'd4) :   
                       *cyc_cnt == 569 ? (8'd3) :   
                       *cyc_cnt == 570 ? (8'd2) :   
                       *cyc_cnt == 571 ? (-8'd3) :   
                       *cyc_cnt == 572 ? (-8'd4) :   
                       *cyc_cnt == 573 ? (-8'd3) :   
                       *cyc_cnt == 574 ? (-8'd2) :   
                       *cyc_cnt == 575 ? (-8'd2) :   
                       *cyc_cnt == 576 ? (-8'd2) :   
                       *cyc_cnt == 577 ? (-8'd2) :   
                       *cyc_cnt == 578 ? (-8'd2) :   
                       *cyc_cnt == 579 ? (-8'd2) :   
                       *cyc_cnt == 580 ? (-8'd2) :   
                       *cyc_cnt == 581 ? (-8'd2) :   
                       *cyc_cnt == 582 ? (8'd3) :   
                       *cyc_cnt == 583 ? (8'd4) :   
                       *cyc_cnt == 584 ? (8'd4) :   
                       *cyc_cnt == 585 ? (8'd4) :   
                       *cyc_cnt == 586 ? (8'd3) :   
                       *cyc_cnt == 587 ? (-8'd4) :   
                       *cyc_cnt == 588 ? (-8'd2) :   
                       *cyc_cnt == 589 ? (-8'd4) :   
                       *cyc_cnt == 590 ? (-8'd3) :   
                       *cyc_cnt == 591 ? (-8'd4) :   
                       *cyc_cnt == 592 ? (-8'd4) :   
                       *cyc_cnt == 593 ? (-8'd4) :   
                       *cyc_cnt == 594 ? (-8'd4) :   
                       *cyc_cnt == 595 ? (-8'd4) :   
                       *cyc_cnt == 596 ? (8'd3) :   
                       *cyc_cnt == 597 ? (8'd4) :   
                       *cyc_cnt == 598 ? (8'd2) :   
                       *cyc_cnt == 599 ? (8'd1) :   
                       *cyc_cnt == 600 ? (8'd3) :
                      
                      

                      8'd0 :
                   *cyc_cnt == 1 ? (8'd0) :
                   8'd0;
                   
      $yy_acc[7:0] = #ship == 0 ? //bluie
                  *cyc_cnt == 1 ? (-8'd2) :   //going up +start loop
                   *cyc_cnt == 2 ? (8'd4) :   
                   *cyc_cnt == 3 ? (8'd3) :   
                   *cyc_cnt == 4 ? (8'd1) :    
                   *cyc_cnt == 5 ? (8'd0) :
                   *cyc_cnt == 6 ? (8'd0) :    //turn around
                   *cyc_cnt == 7 ? (8'd0) :  
                   *cyc_cnt == 8 ? (8'd1) :   
                   *cyc_cnt == 9 ? (8'd3) :    
                   *cyc_cnt == 10 ? (8'd2) :
                   *cyc_cnt == 11 ? (8'd4) :   //going up +start loop
                   *cyc_cnt == 12 ? (8'd0) :   
                   *cyc_cnt == 13 ? (-8'd4) :   
                   *cyc_cnt == 14 ? (-8'd0) :    
                   *cyc_cnt == 15 ? (-8'd0) :
                   *cyc_cnt == 16 ? (-8'd4) :    //turn around
                   *cyc_cnt == 17 ? (-8'd0) :  
                   *cyc_cnt == 18 ? (-8'd1) :   
                   *cyc_cnt == 19 ? (-8'd3) :    
                   *cyc_cnt == 20 ? (-8'd2) :
                   *cyc_cnt == 21 ? (-8'd2) :
                   *cyc_cnt == 22 ? (8'd2) : //switch
                   *cyc_cnt == 23 ? (-8'd4) :
                   *cyc_cnt == 24 ? (-8'd3) :
                   *cyc_cnt == 25 ? (-8'd1) :
                   *cyc_cnt == 26 ? (-8'd0) :
                   *cyc_cnt == 27 ? (-8'd0) :
                   *cyc_cnt == 28 ? (-8'd0) :
                   *cyc_cnt == 29 ? (8'd1) : //used to be 0
                   *cyc_cnt == 30 ? (-8'd0) :
                   *cyc_cnt == 31 ? (8'd1) :
                   *cyc_cnt == 32 ? (8'd3) :
                   *cyc_cnt == 33 ? (-8'd2) :
                   *cyc_cnt == 34 ? (8'd2) :
                   *cyc_cnt == 35 ? (8'd3) :
                   *cyc_cnt == 36 ? (8'd3) :
                   *cyc_cnt == 37 ? (8'd4) : ///ADDED NEW FROM CHATGPT
                   *cyc_cnt == 37 ? (8'd4) :
                  *cyc_cnt == 38 ? (8'd4) :
                  *cyc_cnt == 39 ? (8'd3) :
                  *cyc_cnt == 40 ? (8'd3) :
                  *cyc_cnt == 41 ? (8'd4) : 
                  *cyc_cnt == 42 ? (8'd2) :
                  *cyc_cnt == 43 ? (8'd2) :
                  *cyc_cnt == 44 ? (8'd2) :
                  *cyc_cnt == 45 ? (8'd2) :
                  *cyc_cnt == 46 ? (8'd3) :
                  *cyc_cnt == 47 ? (-8'd3) :
                  *cyc_cnt == 48 ? (8'd2) :
                  *cyc_cnt == 49 ? (-8'd2) :
                  *cyc_cnt == 50 ? (-8'd2) :
                  *cyc_cnt == 51 ? (-8'd2) :
                  *cyc_cnt == 52 ? (-8'd3) :
                  *cyc_cnt == 53 ? (-8'd3) :
                  *cyc_cnt == 54 ? (-8'd3) :
                  *cyc_cnt == 55 ? (-8'd2) :
                  *cyc_cnt == 56 ? (-8'd4) :
                  *cyc_cnt == 57 ? (-8'd3) :
                  *cyc_cnt == 58 ? (-8'd2) :
                  *cyc_cnt == 59 ? (-8'd2) :
                  *cyc_cnt == 60 ? (-8'd4) :
                  *cyc_cnt == 61 ? (-8'd3) :
                  *cyc_cnt == 62 ? (-8'd2) :
                  *cyc_cnt == 63 ? (-8'd3) :
                  *cyc_cnt == 64 ? (8'd4) :
                  *cyc_cnt == 65 ? (8'd3) :
                  *cyc_cnt == 66 ? (8'd2) :
                  *cyc_cnt == 67 ? (8'd2) :
                  *cyc_cnt == 68 ? (8'd2) :
                  *cyc_cnt == 69 ? (8'd2) :
                  *cyc_cnt == 70 ? (8'd2) :
                  *cyc_cnt == 71 ? (8'd2) :
                  *cyc_cnt == 72 ? (8'd2) :
                  *cyc_cnt == 73 ? (8'd2) :
                  *cyc_cnt == 74 ? (8'd3) :
                  *cyc_cnt == 75 ? (8'd4) :
                  *cyc_cnt == 76 ? (8'd4) :
                  *cyc_cnt == 77 ? (-8'd4) :
                  *cyc_cnt == 78 ? (-8'd3) :
                  *cyc_cnt == 79 ? (-8'd2) :
                  *cyc_cnt == 80 ? (-8'd2) : //
                  *cyc_cnt == 81 ? (-8'd4) :
                  *cyc_cnt == 82 ? (-8'd3) :
                  *cyc_cnt == 83 ? (-8'd4) :
                  *cyc_cnt == 84 ? (-8'd4) :
                  *cyc_cnt == 85 ? (-8'd4) :
                  *cyc_cnt == 86 ? (-8'd4) :
                  *cyc_cnt == 87 ? (-8'd4) :
                  *cyc_cnt == 88 ? (-8'd3) :
                  *cyc_cnt == 89 ? (-8'd4) :
                  *cyc_cnt == 90 ? (8'd2) :
                  *cyc_cnt == 91 ? (8'd2) :
                  *cyc_cnt == 92 ? (8'd3) :
                  *cyc_cnt == 93 ? (8'd4) :
                  *cyc_cnt == 94 ? (8'd4) :
                  *cyc_cnt == 95 ? (8'd4) :
                  *cyc_cnt == 96 ? (8'd4) :
                  *cyc_cnt == 97 ? (8'd4) :
                  *cyc_cnt == 98 ? (8'd4) :
                  *cyc_cnt == 99 ? (8'd4) :
                  *cyc_cnt == 100 ? (8'd4) : //SHBKJWEUGRFDBVEIKHUYJ
                  *cyc_cnt == 101 ? (-8'd1) :   
                       *cyc_cnt == 102 ? (-8'd3) :   
                       *cyc_cnt == 103 ? (-8'd2) :   
                       *cyc_cnt == 104 ? (8'd4) :   
                       *cyc_cnt == 105 ? (8'd4) :   
                       *cyc_cnt == 106 ? (8'd4) :   
                       *cyc_cnt == 107 ? (8'd4) :   
                       *cyc_cnt == 108 ? (-8'd4) :   
                       *cyc_cnt == 109 ? (-8'd4) :   
                       *cyc_cnt == 110 ? (-8'd4) :   
                       *cyc_cnt == 111 ? (-8'd1) :   
                       *cyc_cnt == 112 ? (-8'd3) :   
                       *cyc_cnt == 113 ? (-8'd0) :   
                       *cyc_cnt == 114 ? (-8'd0) :   
                       *cyc_cnt == 115 ? (-8'd0) :   
                       *cyc_cnt == 116 ? (-8'd0) :   
                       *cyc_cnt == 117 ? (-8'd0) :   
                       *cyc_cnt == 118 ? (-8'd1) :   
                       *cyc_cnt == 119 ? (-8'd0) :   
                       *cyc_cnt == 120 ? (-8'd0) :   
                       *cyc_cnt == 121 ? (-8'd0) :   
                       *cyc_cnt == 122 ? (8'd4) :   
                       *cyc_cnt == 123 ? (8'd3) :   
                       *cyc_cnt == 124 ? (8'd1) :   
                       *cyc_cnt == 125 ? (8'd3) :   
                       *cyc_cnt == 126 ? (8'd4) :   
                       *cyc_cnt == 127 ? (8'd0) :   
                       *cyc_cnt == 128 ? (8'd0) :   
                       *cyc_cnt == 129 ? (8'd0) :   
                       *cyc_cnt == 130 ? (8'd0) :   
                       *cyc_cnt == 131 ? (8'd0) :   
                       *cyc_cnt == 132 ? (8'd3) :   
                       *cyc_cnt == 133 ? (8'd3) :   
                       *cyc_cnt == 134 ? (8'd4) :   
                       *cyc_cnt == 135 ? (8'd2) :   
                       *cyc_cnt == 136 ? (8'd2) :   
                       *cyc_cnt == 137 ? (-8'd4) :   
                       *cyc_cnt == 138 ? (-8'd2) :   
                       *cyc_cnt == 139 ? (-8'd3) :   
                       *cyc_cnt == 140 ? (-8'd3) :   
                       *cyc_cnt == 141 ? (-8'd2) :   
                       *cyc_cnt == 142 ? (-8'd2) :   
                       *cyc_cnt == 143 ? (-8'd2) :   
                       *cyc_cnt == 144 ? (-8'd2) :   
                       *cyc_cnt == 145 ? (-8'd3) :   
                       *cyc_cnt == 146 ? (-8'd3) :   
                       *cyc_cnt == 147 ? (-8'd3) :   
                       *cyc_cnt == 148 ? (-8'd2) :   
                       *cyc_cnt == 149 ? (+8'd4) :   
                       *cyc_cnt == 150 ? (+8'd3) :   
                       *cyc_cnt == 151 ? (+8'd2) :   
                       *cyc_cnt == 152 ? (+8'd2) :   
                       *cyc_cnt == 153 ? (+8'd4) :   
                       *cyc_cnt == 154 ? (+8'd3) :   
                       *cyc_cnt == 155 ? (+8'd2) :   
                       *cyc_cnt == 156 ? (-8'd3) :   
                       *cyc_cnt == 157 ? (-8'd4) :   
                       *cyc_cnt == 158 ? (-8'd3) :   
                       *cyc_cnt == 159 ? (-8'd2) :   
                       *cyc_cnt == 160 ? (-8'd2) :   
                       *cyc_cnt == 161 ? (-8'd2) :   
                       *cyc_cnt == 162 ? (-8'd2) :   
                       *cyc_cnt == 163 ? (-8'd2) :   
                       *cyc_cnt == 164 ? (-8'd2) :   
                       *cyc_cnt == 165 ? (8'd2) :   
                       *cyc_cnt == 166 ? (8'd2) :   
                       *cyc_cnt == 167 ? (8'd3) :   
                       *cyc_cnt == 168 ? (8'd4) :   
                       *cyc_cnt == 169 ? (8'd4) :   
                       *cyc_cnt == 170 ? (8'd4) :   
                       *cyc_cnt == 171 ? (8'd3) :   
                       *cyc_cnt == 172 ? (8'd4) :   
                       *cyc_cnt == 173 ? (8'd2) :   
                       *cyc_cnt == 174 ? (8'd4) :   
                       *cyc_cnt == 175 ? (8'd3) :   
                       *cyc_cnt == 176 ? (8'd4) :   
                       *cyc_cnt == 177 ? (8'd4) :   
                       *cyc_cnt == 178 ? (8'd4) :   
                       *cyc_cnt == 179 ? (8'd4) :   
                       *cyc_cnt == 180 ? (-8'd4) :   
                       *cyc_cnt == 181 ? (-8'd3) :   
                       *cyc_cnt == 182 ? (-8'd4) :   
                       *cyc_cnt == 183 ? (-8'd2) :   
                       *cyc_cnt == 184 ? (-8'd1) :   
                       *cyc_cnt == 185 ? (-8'd3) :   
                       *cyc_cnt == 186 ? (-8'd2) :   
                       *cyc_cnt == 187 ? (-8'd4) :   
                       *cyc_cnt == 188 ? (-8'd0) :   
                       *cyc_cnt == 189 ? (-8'd4) :   
                       *cyc_cnt == 190 ? (-8'd0) :   
                       *cyc_cnt == 191 ? (-8'd4) :   
                       *cyc_cnt == 192 ? (8'd4) :   
                       *cyc_cnt == 193 ? (8'd0) :   
                       *cyc_cnt == 194 ? (8'd1) :   
                       *cyc_cnt == 195 ? (8'd3) :   
                       *cyc_cnt == 196 ? (8'd2) :   
                       *cyc_cnt == 197 ? (8'd2) :   
                       *cyc_cnt == 198 ? (8'd2) :   
                       *cyc_cnt == 199 ? (8'd4) :   
                       *cyc_cnt == 200 ? (8'd3) :   
                       *cyc_cnt == 201 ? (8'd1) :   
                       *cyc_cnt == 202 ? (8'd0) :   
                       *cyc_cnt == 203 ? (8'd0) :   
                       *cyc_cnt == 204 ? (8'd0) :   
                       *cyc_cnt == 205 ? (-8'd4) :   
                       *cyc_cnt == 206 ? (-8'd3) :   
                       *cyc_cnt == 207 ? (-8'd1) :   
                       *cyc_cnt == 208 ? (-8'd3) :   
                       *cyc_cnt == 209 ? (-8'd4) :   
                       *cyc_cnt == 210 ? (-8'd4) :   
                       *cyc_cnt == 211 ? (-8'd3) :   
                       *cyc_cnt == 212 ? (-8'd3) :   
                       *cyc_cnt == 213 ? (-8'd4) :   
                       *cyc_cnt == 214 ? (-8'd4) :   
                       *cyc_cnt == 215 ? (-8'd3) :   
                       *cyc_cnt == 216 ? (-8'd3) :   
                       *cyc_cnt == 217 ? (-8'd4) :   
                       *cyc_cnt == 218 ? (8'd2) :   
                       *cyc_cnt == 219 ? (8'd4) :   
                       *cyc_cnt == 220 ? (8'd2) :   
                       *cyc_cnt == 221 ? (8'd2) :   
                       *cyc_cnt == 222 ? (8'd3) :   
                       *cyc_cnt == 223 ? (8'd3) :   
                       *cyc_cnt == 224 ? (8'd2) :   
                       *cyc_cnt == 225 ? (8'd2) :   
                       *cyc_cnt == 226 ? (8'd2) :   
                       *cyc_cnt == 227 ? (8'd2) :   
                       *cyc_cnt == 228 ? (8'd3) :   
                       *cyc_cnt == 229 ? (8'd3) :   
                       *cyc_cnt == 230 ? (8'd3) :   
                       *cyc_cnt == 231 ? (8'd2) :   
                       *cyc_cnt == 232 ? (8'd4) :   
                       *cyc_cnt == 233 ? (8'd3) :   
                       *cyc_cnt == 234 ? (-8'd4) :   
                       *cyc_cnt == 235 ? (-8'd2) :   
                       *cyc_cnt == 236 ? (-8'd4) :   
                       *cyc_cnt == 237 ? (-8'd3) :   
                       *cyc_cnt == 238 ? (-8'd2) :   
                       *cyc_cnt == 239 ? (-8'd3) :   
                       *cyc_cnt == 240 ? (-8'd4) :   
                       *cyc_cnt == 241 ? (-8'd3) :   
                       *cyc_cnt == 242 ? (-8'd2) :   
                       *cyc_cnt == 243 ? (-8'd2) :   
                       *cyc_cnt == 244 ? (-8'd2) :   
                       *cyc_cnt == 245 ? (-8'd2) :   
                       *cyc_cnt == 246 ? (-8'd2) :   
                       *cyc_cnt == 247 ? (8'd4) :   
                       *cyc_cnt == 248 ? (8'd2) :   
                       *cyc_cnt == 249 ? (8'd2) :   
                       *cyc_cnt == 250 ? (8'd3) :   
                       *cyc_cnt == 251 ? (8'd4) :   
                       *cyc_cnt == 252 ? (8'd4) :   
                       *cyc_cnt == 253 ? (8'd4) :   
                       *cyc_cnt == 254 ? (8'd3) :   
                       *cyc_cnt == 255 ? (8'd4) :   
                       *cyc_cnt == 256 ? (8'd2) :   
                       *cyc_cnt == 257 ? (8'd4) :   
                       *cyc_cnt == 258 ? (-8'd3) :   
                       *cyc_cnt == 259 ? (-8'd4) :   
                       *cyc_cnt == 260 ? (-8'd4) :   
                       *cyc_cnt == 261 ? (-8'd4) :   
                       *cyc_cnt == 262 ? (-8'd4) :   
                       *cyc_cnt == 263 ? (-8'd4) :   
                       *cyc_cnt == 264 ? (-8'd3) :   
                       *cyc_cnt == 265 ? (-8'd4) :   
                       *cyc_cnt == 266 ? (-8'd2) :   
                       *cyc_cnt == 267 ? (8'd1) :   
                       *cyc_cnt == 268 ? (8'd3) :   
                       *cyc_cnt == 269 ? (8'd2) :   
                       *cyc_cnt == 270 ? (8'd4) :   
                       *cyc_cnt == 271 ? (8'd0) :   
                       *cyc_cnt == 272 ? (8'd4) :   
                       *cyc_cnt == 273 ? (8'd0) :   
                       *cyc_cnt == 274 ? (8'd4) :   
                       *cyc_cnt == 275 ? (-8'd4) :   
                       *cyc_cnt == 276 ? (-8'd0) :   
                       *cyc_cnt == 277 ? (-8'd1) :   
                       *cyc_cnt == 278 ? (-8'd3) :   
                       *cyc_cnt == 279 ? (-8'd2) :   
                       *cyc_cnt == 280 ? (-8'd2) :   
                       *cyc_cnt == 281 ? (8'd2) :   
                       *cyc_cnt == 282 ? (-8'd4) :   
                       *cyc_cnt == 283 ? (8'd3) :   
                       *cyc_cnt == 284 ? (8'd1) :   
                       *cyc_cnt == 285 ? (8'd4) :   
                       *cyc_cnt == 286 ? (8'd0) :   
                       *cyc_cnt == 287 ? (8'd0) :   
                       *cyc_cnt == 288 ? (8'd1) :   
                       *cyc_cnt == 289 ? (8'd3) :   
                       *cyc_cnt == 290 ? (8'd1) :   
                       *cyc_cnt == 291 ? (8'd3) :   
                       *cyc_cnt == 292 ? (8'd4) :   
                       *cyc_cnt == 293 ? (8'd4) :   
                       *cyc_cnt == 294 ? (8'd3) :   
                       *cyc_cnt == 295 ? (8'd3) :   
                       *cyc_cnt == 296 ? (-8'd4) :   
                       *cyc_cnt == 297 ? (-8'd4) :   
                       *cyc_cnt == 298 ? (-8'd3) :   
                       *cyc_cnt == 299 ? (-8'd3) :   
                       *cyc_cnt == 300 ? (-8'd4) :   
                       *cyc_cnt == 301 ? (-8'd2) :   
                       *cyc_cnt == 302 ? (-8'd2) :   
                       *cyc_cnt == 303 ? (-8'd2) :   
                       *cyc_cnt == 304 ? (-8'd2) :   
                       *cyc_cnt == 305 ? (-8'd3) :   
                       *cyc_cnt == 306 ? (-8'd3) :   
                       *cyc_cnt == 307 ? (-8'd2) :   
                       *cyc_cnt == 308 ? (8'd4) :   
                       *cyc_cnt == 309 ? (8'd2) :   
                       *cyc_cnt == 310 ? (8'd2) :   
                       *cyc_cnt == 311 ? (8'd3) :   
                       *cyc_cnt == 312 ? (8'd3) :   
                       *cyc_cnt == 313 ? (-8'd3) :   
                       *cyc_cnt == 314 ? (-8'd2) :   
                       *cyc_cnt == 315 ? (8'd4) :   
                       *cyc_cnt == 316 ? (8'd3) :   
                       *cyc_cnt == 317 ? (8'd2) :   
                       *cyc_cnt == 318 ? (8'd2) :   
                       *cyc_cnt == 319 ? (8'd4) :   
                       *cyc_cnt == 320 ? (8'd3) :   
                       *cyc_cnt == 321 ? (8'd2) :   
                       *cyc_cnt == 322 ? (8'd3) :   
                       *cyc_cnt == 323 ? (-8'd4) :   
                       *cyc_cnt == 324 ? (-8'd3) :   
                       *cyc_cnt == 325 ? (-8'd2) :   
                       *cyc_cnt == 326 ? (-8'd2) :   
                       *cyc_cnt == 327 ? (-8'd4) :   
                       *cyc_cnt == 328 ? (-8'd2) :   
                       *cyc_cnt == 329 ? (-8'd2) :   
                       *cyc_cnt == 330 ? (-8'd2) :   
                       *cyc_cnt == 331 ? (-8'd2) :   
                       *cyc_cnt == 332 ? (-8'd2) :   
                       *cyc_cnt == 333 ? (-8'd3) :   
                       *cyc_cnt == 334 ? (-8'd4) :   
                       *cyc_cnt == 335 ? (-8'd4) :   
                       *cyc_cnt == 336 ? (8'd4) :   
                       *cyc_cnt == 337 ? (8'd3) :   
                       *cyc_cnt == 338 ? (8'd3) :   
                       *cyc_cnt == 339 ? (8'd3) :   
                       *cyc_cnt == 340 ? (8'd4) :   
                       *cyc_cnt == 341 ? (8'd3) :   
                       *cyc_cnt == 342 ? (8'd4) :   
                       *cyc_cnt == 343 ? (8'd4) :   
                       *cyc_cnt == 344 ? (8'd4) :   
                       *cyc_cnt == 345 ? (-8'd4) :   
                       *cyc_cnt == 346 ? (-8'd4) :   
                       *cyc_cnt == 347 ? (-8'd3) :   
                       *cyc_cnt == 348 ? (-8'd4) :   
                       *cyc_cnt == 349 ? (-8'd2) :   
                       *cyc_cnt == 350 ? (-8'd1) :   
                       *cyc_cnt == 351 ? (-8'd3) :   
                       *cyc_cnt == 352 ? (-8'd2) :   
                       *cyc_cnt == 353 ? (8'd4) :   
                       *cyc_cnt == 354 ? (8'd0) :   
                       *cyc_cnt == 355 ? (8'd4) :   
                       *cyc_cnt == 356 ? (8'd0) :   
                       *cyc_cnt == 357 ? (8'd4) :   
                       *cyc_cnt == 358 ? (8'd4) :   
                       *cyc_cnt == 359 ? (8'd0) :   
                       *cyc_cnt == 360 ? (8'd1) :   
                       *cyc_cnt == 361 ? (8'd3) :   
                       *cyc_cnt == 362 ? (8'd2) :   
                       *cyc_cnt == 363 ? (-8'd2) :   
                       *cyc_cnt == 364 ? (-8'd2) :   
                       *cyc_cnt == 365 ? (-8'd4) :   
                       *cyc_cnt == 366 ? (-8'd3) :   
                       *cyc_cnt == 367 ? (-8'd1) :   
                       *cyc_cnt == 368 ? (-8'd0) :   
                       *cyc_cnt == 369 ? (-8'd0) :   
                       *cyc_cnt == 370 ? (-8'd0) :   
                       *cyc_cnt == 371 ? (-8'd1) :   
                       *cyc_cnt == 372 ? (-8'd3) :   
                       *cyc_cnt == 373 ? (-8'd1) :   
                       *cyc_cnt == 374 ? (-8'd3) :   
                       *cyc_cnt == 375 ? (-8'd4) :   
                       *cyc_cnt == 376 ? (-8'd4) :   
                       *cyc_cnt == 377 ? (8'd3) :   
                       *cyc_cnt == 378 ? (8'd3) :   
                       *cyc_cnt == 379 ? (8'd4) :   
                       *cyc_cnt == 380 ? (8'd4) :   
                       *cyc_cnt == 381 ? (8'd3) :   
                       *cyc_cnt == 382 ? (8'd3) :   
                       *cyc_cnt == 383 ? (8'd4) :   
                       *cyc_cnt == 384 ? (8'd2) :   
                       *cyc_cnt == 385 ? (8'd2) :   
                       *cyc_cnt == 386 ? (8'd2) :   
                       *cyc_cnt == 387 ? (8'd2) :   
                       *cyc_cnt == 388 ? (8'd3) :   
                       *cyc_cnt == 389 ? (8'd3) :   
                       *cyc_cnt == 390 ? (-8'd4) :   
                       *cyc_cnt == 391 ? (-8'd2) :   
                       *cyc_cnt == 392 ? (-8'd2) :   
                       *cyc_cnt == 393 ? (-8'd2) :   
                       *cyc_cnt == 394 ? (-8'd3) :   
                       *cyc_cnt == 395 ? (-8'd3) :   
                       *cyc_cnt == 396 ? (-8'd3) :   
                       *cyc_cnt == 397 ? (-8'd2) :   
                       *cyc_cnt == 398 ? (-8'd4) :   
                       *cyc_cnt == 399 ? (-8'd3) :   
                       *cyc_cnt == 400 ? (-8'd2) :   
                       *cyc_cnt == 401 ? (-8'd2) :   
                       *cyc_cnt == 402 ? (-8'd4) :   
                       *cyc_cnt == 403 ? (-8'd3) :   
                       *cyc_cnt == 404 ? (-8'd2) :   
                       *cyc_cnt == 405 ? (-8'd3) :   
                       *cyc_cnt == 406 ? (8'd4) :   
                       *cyc_cnt == 407 ? (8'd3) :   
                       *cyc_cnt == 408 ? (8'd2) :   
                       *cyc_cnt == 409 ? (8'd2) :   
                       *cyc_cnt == 410 ? (8'd2) :   
                       *cyc_cnt == 411 ? (8'd2) :   
                       *cyc_cnt == 412 ? (8'd2) :   
                       *cyc_cnt == 413 ? (8'd2) :   
                       *cyc_cnt == 414 ? (8'd2) :   
                       *cyc_cnt == 415 ? (8'd2) :   
                       *cyc_cnt == 416 ? (8'd3) :   
                       *cyc_cnt == 417 ? (8'd4) :   
                       *cyc_cnt == 418 ? (8'd4) :   
                       *cyc_cnt == 419 ? (8'd4) :   
                       *cyc_cnt == 420 ? (8'd3) :   
                       *cyc_cnt == 421 ? (-8'd4) :   
                       *cyc_cnt == 422 ? (-8'd2) :   
                       *cyc_cnt == 423 ? (-8'd4) :   
                       *cyc_cnt == 424 ? (-8'd3) :   
                       *cyc_cnt == 425 ? (-8'd4) :   
                       *cyc_cnt == 426 ? (-8'd4) :   
                       *cyc_cnt == 427 ? (-8'd4) :   
                       *cyc_cnt == 428 ? (-8'd4) :   
                       *cyc_cnt == 429 ? (-8'd4) :   
                       *cyc_cnt == 430 ? (8'd3) :   
                       *cyc_cnt == 431 ? (8'd4) :   
                       *cyc_cnt == 432 ? (8'd2) :   
                       *cyc_cnt == 433 ? (8'd1) :   
                       *cyc_cnt == 434 ? (8'd3) :   
                       *cyc_cnt == 435 ? (8'd2) :   
                       *cyc_cnt == 436 ? (8'd4) :   
                       *cyc_cnt == 437 ? (8'd0) :   
                       *cyc_cnt == 438 ? (8'd4) :   
                       *cyc_cnt == 439 ? (8'd0) :   
                       *cyc_cnt == 440 ? (8'd4) :   
                       *cyc_cnt == 441 ? (-8'd4) :   
                       *cyc_cnt == 442 ? (-8'd0) :   
                       *cyc_cnt == 443 ? (-8'd1) :   
                       *cyc_cnt == 444 ? (-8'd3) :   
                       *cyc_cnt == 445 ? (-8'd2) :   
                       *cyc_cnt == 446 ? (-8'd2) :   
                       *cyc_cnt == 447 ? (8'd2) :   
                       *cyc_cnt == 448 ? (-8'd4) :   
                       *cyc_cnt == 449 ? (-8'd3) :   
                       *cyc_cnt == 450 ? (-8'd1) :   
                       *cyc_cnt == 451 ? (-8'd0) :   
                       *cyc_cnt == 452 ? (-8'd0) :   
                       *cyc_cnt == 453 ? (-8'd0) :   
                       *cyc_cnt == 454 ? (-8'd1) :   
                       *cyc_cnt == 455 ? (-8'd3) :   
                       *cyc_cnt == 456 ? (-8'd1) :   
                       *cyc_cnt == 457 ? (-8'd3) :   
                       *cyc_cnt == 458 ? (-8'd4) :   
                       *cyc_cnt == 459 ? (-8'd4) :   
                       *cyc_cnt == 460 ? (8'd3) :   
                       *cyc_cnt == 461 ? (8'd3) :   
                       *cyc_cnt == 462 ? (8'd4) :   
                       *cyc_cnt == 463 ? (8'd4) :   
                       *cyc_cnt == 464 ? (8'd3) :   
                       *cyc_cnt == 465 ? (8'd3) :   
                       *cyc_cnt == 466 ? (8'd4) :   
                       *cyc_cnt == 467 ? (8'd2) :   
                       *cyc_cnt == 468 ? (8'd2) :   
                       *cyc_cnt == 469 ? (8'd2) :   
                       *cyc_cnt == 470 ? (8'd2) :   
                       *cyc_cnt == 471 ? (8'd3) :   
                       *cyc_cnt == 472 ? (8'd3) :   
                       *cyc_cnt == 473 ? (8'd2) :   
                       *cyc_cnt == 474 ? (-8'd2) :   
                       *cyc_cnt == 475 ? (-8'd2) :   
                       *cyc_cnt == 476 ? (-8'd2) :   
                       *cyc_cnt == 477 ? (-8'd3) :   
                       *cyc_cnt == 478 ? (-8'd3) :   
                       *cyc_cnt == 479 ? (-8'd3) :   
                       *cyc_cnt == 480 ? (-8'd2) :   
                       *cyc_cnt == 481 ? (-8'd4) :   
                       *cyc_cnt == 482 ? (-8'd3) :   
                       *cyc_cnt == 483 ? (-8'd2) :   
                       *cyc_cnt == 484 ? (-8'd2) :   
                       *cyc_cnt == 485 ? (-8'd4) :   
                       *cyc_cnt == 486 ? (-8'd3) :   
                       *cyc_cnt == 487 ? (-8'd2) :   
                       *cyc_cnt == 488 ? (-8'd3) :   
                       *cyc_cnt == 489 ? (8'd4) :   
                       *cyc_cnt == 490 ? (8'd3) :   
                       *cyc_cnt == 491 ? (8'd2) :   
                       *cyc_cnt == 492 ? (8'd2) :   
                       *cyc_cnt == 493 ? (8'd2) :   
                       *cyc_cnt == 495 ? (8'd2) :   
                       *cyc_cnt == 496 ? (8'd2) :   
                       *cyc_cnt == 497 ? (8'd2) :   
                       *cyc_cnt == 498 ? (8'd2) :   
                       *cyc_cnt == 499 ? (8'd3) :   
                       *cyc_cnt == 500 ? (8'd4) :   
                       *cyc_cnt == 501 ? (8'd4) :   
                       *cyc_cnt == 502 ? (8'd4) :   
                       *cyc_cnt == 503 ? (8'd3) :   
                       *cyc_cnt == 504 ? (-8'd4) :   
                       *cyc_cnt == 505 ? (-8'd2) :   
                       *cyc_cnt == 506 ? (-8'd4) :   
                       *cyc_cnt == 507 ? (-8'd3) :   
                       *cyc_cnt == 508 ? (-8'd4) :   
                       *cyc_cnt == 509 ? (-8'd4) :   
                       *cyc_cnt == 510 ? (-8'd4) :   
                       *cyc_cnt == 511 ? (-8'd4) :   
                       *cyc_cnt == 512 ? (-8'd4) :   
                       *cyc_cnt == 513 ? (8'd3) :   
                       *cyc_cnt == 514 ? (8'd4) :   
                       *cyc_cnt == 515 ? (8'd2) :   
                       *cyc_cnt == 516 ? (8'd1) :   
                       *cyc_cnt == 517 ? (8'd3) :   
                       *cyc_cnt == 518 ? (8'd2) :   
                       *cyc_cnt == 519 ? (8'd4) :   
                       *cyc_cnt == 520 ? (8'd0) :   
                       *cyc_cnt == 521 ? (-8'd4) :   
                       *cyc_cnt == 522 ? (-8'd0) :   
                       *cyc_cnt == 523 ? (-8'd4) :   
                       *cyc_cnt == 524 ? (-8'd4) :   
                       *cyc_cnt == 525 ? (-8'd0) :   
                       *cyc_cnt == 526 ? (-8'd1) :   
                       *cyc_cnt == 527 ? (-8'd3) :   
                       *cyc_cnt == 528 ? (-8'd2) :   
                       *cyc_cnt == 529 ? (-8'd2) :   
                       *cyc_cnt == 530 ? (8'd2) :   
                       *cyc_cnt == 531 ? (-8'd4) :   
                       *cyc_cnt == 532 ? (-8'd3) :   
                       *cyc_cnt == 533 ? (-8'd1) :   
                       *cyc_cnt == 534 ? (8'd4) :   
                       *cyc_cnt == 535 ? (8'd3) :   
                       *cyc_cnt == 536 ? (8'd0) :   
                       *cyc_cnt == 537 ? (8'd1) :   
                       *cyc_cnt == 538 ? (8'd3) :   
                       *cyc_cnt == 539 ? (8'd1) :   
                       *cyc_cnt == 540 ? (8'd3) :   
                       *cyc_cnt == 541 ? (8'd4) :   
                       *cyc_cnt == 542 ? (8'd4) :   
                       *cyc_cnt == 543 ? (8'd3) :   
                       *cyc_cnt == 544 ? (8'd3) :   
                       *cyc_cnt == 545 ? (8'd4) :   
                       *cyc_cnt == 546 ? (8'd4) :   
                       *cyc_cnt == 547 ? (-8'd3) :   
                       *cyc_cnt == 548 ? (-8'd3) :   
                       *cyc_cnt == 549 ? (-8'd4) :   
                       *cyc_cnt == 550 ? (-8'd2) :   
                       *cyc_cnt == 551 ? (-8'd2) :   
                       *cyc_cnt == 552 ? (-8'd2) :   
                       *cyc_cnt == 553 ? (-8'd2) :   
                       *cyc_cnt == 554 ? (-8'd3) :   
                       *cyc_cnt == 555 ? (-8'd3) :   
                       *cyc_cnt == 556 ? (-8'd2) :   
                       *cyc_cnt == 557 ? (-8'd4) :   
                       *cyc_cnt == 558 ? (8'd4) :   
                       *cyc_cnt == 559 ? (8'd2) :   
                       *cyc_cnt == 560 ? (8'd3) :   
                       *cyc_cnt == 561 ? (8'd3) :   
                       *cyc_cnt == 562 ? (8'd3) :   
                       *cyc_cnt == 563 ? (8'd2) :   
                       *cyc_cnt == 564 ? (8'd4) :   
                       *cyc_cnt == 565 ? (8'd3) :   
                       *cyc_cnt == 566 ? (8'd2) :   
                       *cyc_cnt == 567 ? (8'd2) :   
                       *cyc_cnt == 568 ? (8'd4) :   
                       *cyc_cnt == 569 ? (8'd3) :   
                       *cyc_cnt == 570 ? (8'd2) :   
                       *cyc_cnt == 571 ? (-8'd3) :   
                       *cyc_cnt == 572 ? (-8'd4) :   
                       *cyc_cnt == 573 ? (-8'd3) :   
                       *cyc_cnt == 574 ? (-8'd2) :   
                       *cyc_cnt == 575 ? (-8'd2) :   
                       *cyc_cnt == 576 ? (-8'd2) :   
                       *cyc_cnt == 577 ? (-8'd2) :   
                       *cyc_cnt == 578 ? (-8'd2) :   
                       *cyc_cnt == 579 ? (-8'd2) :   
                       *cyc_cnt == 580 ? (-8'd2) :   
                       *cyc_cnt == 581 ? (-8'd2) :   
                       *cyc_cnt == 582 ? (8'd3) :   
                       *cyc_cnt == 583 ? (8'd4) :   
                       *cyc_cnt == 584 ? (8'd4) :   
                       *cyc_cnt == 585 ? (8'd4) :   
                       *cyc_cnt == 586 ? (8'd3) :   
                       *cyc_cnt == 587 ? (-8'd4) :   
                       *cyc_cnt == 588 ? (-8'd2) :   
                       *cyc_cnt == 589 ? (-8'd4) :   
                       *cyc_cnt == 590 ? (-8'd3) :   
                       *cyc_cnt == 591 ? (-8'd4) :   
                       *cyc_cnt == 592 ? (-8'd4) :   
                       *cyc_cnt == 593 ? (-8'd4) :   
                       *cyc_cnt == 594 ? (-8'd4) :   
                       *cyc_cnt == 595 ? (-8'd4) :   
                       *cyc_cnt == 596 ? (8'd3) :   
                       *cyc_cnt == 597 ? (8'd4) :   
                       *cyc_cnt == 598 ? (8'd2) :   
                       *cyc_cnt == 599 ? (8'd1) :   
                       *cyc_cnt == 600 ? (8'd3) :
                  
               
                  
                   
                   8'd0 :
                   // ... 
                   8'd0; //must repeat somehow




      //-----------------------\
      //  Your Code Goes Here  |
      //-----------------------/
      
      // E.g.:
      //$xx_acc[3:0] = 4'd0;
      //$yy_acc[3:0] = 4'd0;
      //$attempt_fire = 1'b0;
      //$fire_dir[1:0] = 2'd0;
      //$attempt_cloak = 1'b0;
      //$attempt_shield = 1'b0;


// [Optional]
// Visualization of your logic for each ship.
\TLV team_60561724_viz(/_top, _team_num)
   m5+io_viz(/_top, _team_num)   /// Visualization of your IOs.
   \viz_js
      m5_DefaultTeamVizBoxAndWhere()
      // Add your own visualization of your own logic here, if you like, within the bounds {left: 0..100, top: 0..100}.
      render() {
         // ... draw using fabric.js and signal values. (See VIZ docs under "LEARN" menu.)
         return [
            // For example...
            new fabric.Text('$destroyed'.asBool() ? "I''m dead! ☹️" : "I''m alive! 😊", {
               left: 10, top: 50, originY: "center", fill: "black", fontSize: 10,
            })
         ];
      },


// Compete!
// This defines the competition to simulate (for development).
// When this file is included as a library (for competition), this code is ignored.
\SV
   // Include the showdown framework.
   m4_include_lib(https://raw.githubusercontent.com/rweda/showdown-2025-space-battle/a211a27da91c5dda590feac280f067096c96e721/showdown_lib.tlv)
   
   m5_makerchip_module
\TLV
   // Enlist teams for battle.
   
   // Your team as the first. Provide:
   //   - your GitHub ID, (as in your \TLV team_* macro, above)
   //   - your team name--anything you like (that isn't crude or disrespectful)
   m5_team(60561724, Bionic-Beavers)
   
   // Choose your opponent.
   // Note that inactive teams must be commented with "///", not "//", to prevent M5 macro evaluation.
   ///m5_team(random, Random)
   ///m5_team(sitting_duck, Sitting Duck)
   m5_team(demo1, Test 1)
   
   
   // Instantiate the Showdown environment.
   m5+showdown(/top, /secret)
   
   *passed = /secret$passed || *cyc_cnt > 100;   // Defines max cycles, up to ~600.
   *failed = /secret$failed;
\SV
   endmodule