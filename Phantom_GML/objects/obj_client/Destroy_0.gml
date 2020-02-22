/// @description Close client

//destroy network
network_destroy(client)

//destroy buffers
buffer_delete(buff)

//destroy lists
ds_list_destroy(network_players)
ds_list_destroy(network_names)
