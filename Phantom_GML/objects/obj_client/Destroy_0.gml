/// @description  close client

// destroy network
network_destroy(client);

// destroy buffers
buffer_delete(buff);

// destroy lists
ds_list_destroy(basicSprites);
ds_list_destroy(basicImages);
ds_list_destroy(basicXs);
ds_list_destroy(basicYs);
ds_list_destroy(characterSprites);
ds_list_destroy(characterImages);
ds_list_destroy(characterXs);
ds_list_destroy(characterYs);
ds_list_destroy(characterHPs);
ds_list_destroy(characterEnergys);
ds_list_destroy(characterNames);

// clear menu server data
ds_list_clear(global.Menu.server_data);

