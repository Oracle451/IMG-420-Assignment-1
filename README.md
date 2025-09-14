# Stick Runner
*A 2D Game Engines (IMG-420): Assignment 1*

Stick Runner is a single level game that lets the player control a stick figure and navigate to the finish flag while avoiding obstacles in their way.

After starting the game through the main menu you can left click when near the red button to toggle the platforms and navigate your way to the green finish flag to win, make sure to avoid the spikes!

---

## Features
- Playable stick-figure character with multiple inputs (move, jump, crouch, sprint, punch/interact).  
- Interactable level elements: health pickups and a platform toggle button.  
- HUD (health monitor), main menu, and pause menu.  
- Win / lose conditions (finish flag = win, spikes = death).  
- Player animations for walking, sprinting, punching, and jumping.  
- Sound effects: pickup obtained, pickup respawned, player damaged, button pressed.

---

## Controls

| Action                | Keyboard / Mouse     | Gamepad             |
|-----------------------|----------------------|---------------------|
| Move Left / Right     | `A` / `D`            | Left Joystick       |
| Crouch                | `Ctrl`               | Left Joystick Down  |
| Jump                  | `Space`              | `A` Button          |
| Sprint                | `Shift`              | Click Left Stick    |
| Punch / Interact      | Left Click           | `X` Button          |
| Pause                 | `Esc`                | Start Button        |

---

# Assignment Requirements

## A Playable Character (3 Forms of Unique Input)
1. Move Left and Right
2. Jump
3. Crouch
4. Sprint
5. Punch and Interact

## Win & Lose Conditions
- **Win**: Reach the **green finish flag**.  
- **Lose**: Dying to the spikes around the map.

---

## Level Interactivity
- **Health Pickup**  
  - Restores player health when collected.
  - Plays "Health Pickup Obtained" SFX.
  - Respawns after a set delay and plays "Health Pickup Respawned" SFX.
- **Platform Toggle Button (Red Button)**  
  - Player can left-click when near the button to toggle platforms.
  - Plays "Button Pressed" SFX and triggers platform state changes (visible/collidable).

---

## GUI
- **HUD**: Health monitor in the top-left corner.
- **Main Menu**: Start or Quit the game (game loads into this menu).
- **Pause Menu**: Can be opened anytime during play.

---

## Animations & Sounds
**Player animations**
- Walk
- Sprint
- Jump
- Punch / Interact

**Sound effects**
- Health Pickup Obtained  
- Health Pickup Respawned  
- Player Damaged  
- Button Pressed

---


