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

\TLV Bionic-Beavers_60561724(/_top)
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
                       *cyc_cnt == 100 ? (8'd2) :


                      
  

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
                      *cyc_cnt == 99 ? (8'd4) :
                       *cyc_cnt == 100 ? (8'd2) :
                      
                      

                      8'd0 :
                   *cyc_cnt == 1 ? (8'd0) :
                   8'd0;
                   
      $yy_acc[7:0] = #ship == 0 ?
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
                  *cyc_cnt == 100 ? (8'd4) :
                   
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
\TLV Bionic-Beavers_60561724_viz(/_top, _team_num)
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
   m5_team(YOUR_GITHUB_ID, YOUR_TEAM_NAME)
   
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