/// @description Insert description here
// You can write your code in this editor
var explosion = instance_create_layer(x,y,"Instances_1",obj_explosion)
explosion.connect_id = player.connect_id
audio_play_sound(snd_explosion, 1, 0)
player.Train = instance_create_layer(player.x,player.y,"Instances_1",obj_train)
player.Train.player = player;

player.game_score --
if player.game_score < 0{
	player.game_score = 0
}