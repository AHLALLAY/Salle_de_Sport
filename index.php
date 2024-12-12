<?php
require_once('config/db.php');
require_once('config/functions.php');

$result = display_data();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Members</title>
</head>

<body class="flex bg-gray-100">
    <!-- Sidebar -->
    <aside class="h-screen w-64 bg-green-400 p-6 fixed">
        <button 
            onclick="toggleTable()" 
            class="w-full bg-white text-green-600 mt-2 px-4 py-2 rounded-lg shadow hover:bg-green-50 transition-colors duration-200">
            Afficher/Masquer Membres
        </button>
        <button 
            onclick="window.location.href='./config/reservation_form.php'" 
            class="w-full bg-white text-green-600 mt-2 px-4 py-2 rounded-lg shadow hover:bg-green-50 transition-colors duration-200">
            Ajouter une réservation
        </button>
    </aside>

    <!-- Main Content -->
    <main class="ml-64 w-full p-8">
        <div class="max-w-full bg-white rounded-lg shadow-lg">
            <!-- Header -->
            <div class="px-4 py-4 border-b border-gray-200">
                <h2 class="text-2xl font-semibold text-gray-800">Members</h2>
            </div>
            
            <!-- Table Container -->
            <div class="p-6">
                <div class="overflow-x-auto">
                    <?php if ($result && mysqli_num_rows($result) > 0) { ?>
                        <table id="membersTable" class="min-w-full bg-white rounded-lg" style="display: none;">
                            <thead>
                                <tr class="bg-gray-50 border-b border-gray-200">
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Prénom</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date de naissance</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date d'inscription</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Statut</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <?php while ($row = mysqli_fetch_assoc($result)) { ?>
                                    <tr class="hover:bg-gray-50 transition-colors duration-200">
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['id_membre']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['nom']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['prenom']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['email']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['telephone']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['date_naissance']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm text-gray-900"><?php echo htmlspecialchars($row['date_inscription']); ?></td>
                                        <td class="px-4 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                <?php echo htmlspecialchars($row['statut']); ?>
                                            </span>
                                        </td>
                                        <td class="px-4 py-4 whitespace-nowrap text-sm font-medium">
                                            <a href="delete_member.php?id=<?php echo urlencode($row['id_membre']); ?>" 
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce membre ?');"
                                               class="text-red-600 hover:bg-red-600 hover:text-white hover:rounded-lg hover:p-2">
                                                Supprimer
                                            </a>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    <?php } else { ?>
                        <p class="text-gray-500 text-center py-4">Aucun membre trouvé</p>
                    <?php } ?>
                </div>
            </div>
        </div>
    </main>

    <script>
        function toggleTable() {
            var table = document.getElementById('membersTable');
            if (table.style.display === 'none') {
                table.style.display = 'table';
            } else {
                table.style.display = 'none';
            }
        }
    </script>
</body>
</html>