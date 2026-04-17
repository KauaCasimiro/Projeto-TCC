// No Draw Event
if (hit_flash_timer > 0) {
	shader_set(shader_hit);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, hit_flash_color, hit_flash_alpha);
	shader_reset();
} else {
    draw_self(); // Desenha o sprite normalmente
}