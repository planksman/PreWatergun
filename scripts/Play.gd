##This file is part of PreWatergun.

##PreWatergun is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

##PreWatergun is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

##You should have received a copy of the GNU Affero General Public License along with PreWatergun. If not, see <https://www.gnu.org/licenses/>.
extends Node



func _on_PlayOffline_pressed():
	SceneManager.change_scene("Fade","res://DemoGame.tscn")
