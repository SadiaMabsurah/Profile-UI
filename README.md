<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>

<body style="font-family: Arial, sans-serif; line-height: 1.6;">

<h1>📱 Flutter Profile UI</h1>

<p><b>Name:</b> Sadia Mabsurah</p>
<p><b>ID:</b> 232-134-002</p>

<h2>📌 Features</h2>
<ul>
  <li>Profile Picture</li>
  <li>Name & Profession</li>
  <li>Profile Details (Email, ID, Department, Batch)</li>
  <li>Statistics (Posts, Followers, Following, Projects)</li>
  <li>Action Buttons (Follow, Message, Call)</li>
  <li>About Me Section</li>
  <li>Dark / Light Mode</li>
</ul>

<h2>🧩 How Widgets Were Used</h2>

<ul>
  <li>Scaffold → Used as the main page structure for the profile screen with AppBar and body.</li>

  <li>AppBar → Used at the top to show back button, title (Profile), search icon, theme toggle, and menu icon.</li>

  <li>Container → Used in multiple places like profile header, stats card, about card, and info cards for styling and background design.</li>

  <li>Padding → Used to give space around the main content inside the profile screen.</li>

  <li>SizedBox → Used to add spacing between UI sections like profile header, name, stats, and buttons.</li>

  <li>Center → Used to center the profile avatar inside the header section.</li>

  <li>Row → Used to arrange items horizontally like stats (Posts, Followers, Following, Projects) and action buttons.</li>

  <li>Column → Used to arrange all sections vertically like profile info, stats, about section, and details.</li>

  <li>Expanded → Used inside Row to make stats and buttons share equal width.</li>

  <li>Stack → Used in ProfileHeader to place background gradient and avatar on top of it.</li>

  <li>setState() → Used to update UI when toggling dark mode and when follow/unfollow button changes follower count.</li>
</ul>
</html>
