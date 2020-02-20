/// @description  draw server data
draw_set_alpha(1);
if (view_current == 0) {
    if (global.Menu.state == STATE_GAME) {
        // draw all basic sprites
        var sprites = ds_list_size(basicSprites);
        for (i = 0; i < sprites; i++) {
            draw_sprite(ds_list_find_value(basicSprites, i), ds_list_find_value(basicImages, i), ds_list_find_value(basicXs, i), ds_list_find_value(basicYs, i));
            }
        
        // draw all character sprites
        var sprites = ds_list_size(characterSprites);
        for (i = 0; i < sprites; i++) {
            var cx = ds_list_find_value(characterXs, i);
            var cy = ds_list_find_value(characterYs, i);
            
            // draw sprite
            draw_sprite(ds_list_find_value(characterSprites, i), ds_list_find_value(characterImages, i), cx, cy);
            
            // draw bars
            draw_healthbar(cx, cy-4, cx+17, cy-8, ds_list_find_value(characterHPs, i),c_white,c_red,c_green,0,false,true); // hp
            draw_healthbar(cx, cy, cx+17, cy-4,ds_list_find_value(characterEnergys, i),c_white,c_white,c_teal,0,false,true); // energy
            
            // draw name
            draw_set_alpha(0.5);
            draw_set_color(c_white);
            draw_set_halign(fa_middle);
            draw_text(cx+8, cy+16, string_hash_to_newline(ds_list_find_value(characterNames, i)));
            draw_set_alpha(1);
            }
        
        // draw water
        draw_set_alpha(.5);
        var buffer = 32;
        draw_rectangle_color(buffer, room_height-buffer, room_width-buffer, room_height-buffer-water_height, c_aqua, c_aqua, c_navy, c_navy, false);
        }
    }

draw_set_alpha(1);