<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/YOUR_FONT_AWESOME_KIT.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 flex h-screen">

<!-- Sidebar -->
<aside class="w-64 bg-gray-900 text-white flex flex-col p-5">
    <h2 class="text-2xl font-semibold mb-5">Admin Dashboard</h2>
    <nav>
        <ul>
            <li class="mb-3"><a href="dashboard.html" class="flex items-center gap-2 hover:text-gray-300"><i class="fas fa-home"></i> Dashboard</a></li>
            <li class="mb-3"><a href="profile.html" class="flex items-center gap-2 hover:text-gray-300"><i class="fas fa-user"></i> Profile</a></li>
            <li class="mb-3"><a href="customers.html" class="flex items-center gap-2 hover:text-gray-300"><i class="fas fa-users"></i> Customers</a></li>
            <li class="mb-3"><a href="manageReviews.jsp" class="flex items-center gap-2 hover:text-gray-300"><i class="fas fa-users"></i> FeedBack</a></li>
            <li class="mb-3"><a href="rolemgt.html" class="flex items-center gap-2 hover:text-gray-300"><i class="fas fa-user-shield"></i> Role Management</a></li>
        </ul>
    </nav>
</aside>

<!-- Main Content -->
<div class="flex-1 flex flex-col">

    <!-- Top Bar -->
    <header class="bg-white shadow p-4 flex justify-between items-center">
        <h1 class="text-xl font-semibold">Profile Management</h1>
        <div class="flex items-center gap-4">
            <span class="text-gray-700">Welcome, <strong>Admin</strong></span>
            <button class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </header>

    <!-- Content Area -->
    <main class="p-6">
        <div class="flex justify-between items-center">
            <h2 class="text-2xl font-semibold mb-4">Personal Details</h2>
            <button onclick="openEditProfile()" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                <i class="fas fa-edit"></i> Edit Profile
            </button>
        </div>

        <div class="bg-white shadow-md rounded-lg p-6">
            <form>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Full Name</label>
                        <input type="text" id="name" class="w-full border border-gray-300 rounded px-3 py-2 outline-none" value="John Doe" disabled>
                    </div>
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Email</label>
                        <input type="email" id="email" class="w-full border border-gray-300 rounded px-3 py-2 outline-none" value="john.doe@example.com" disabled>
                    </div>
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Phone</label>
                        <input type="tel" id="phone" class="w-full border border-gray-300 rounded px-3 py-2 outline-none" value="+1 234 567 8900" disabled>
                    </div>
                    <div>
                        <label class="block text-gray-700 font-medium mb-2">Address</label>
                        <input type="text" id="address" class="w-full border border-gray-300 rounded px-3 py-2 outline-none" value="123 Street, City, Country" disabled>
                    </div>
                </div>
            </form>
        </div>

        <!-- Payment Methods -->
        <h2 class="text-2xl font-semibold mt-8 mb-4">Payment Methods</h2>

        <div class="bg-white shadow-md rounded-lg p-6">
            <div class="flex justify-between mb-4">
                <h3 class="text-lg font-semibold">Saved Cards</h3>
                <button onclick="openPaymentForm()" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                    <i class="fas fa-plus"></i> Add Payment Method
                </button>
            </div>

            <table class="min-w-full">
                <thead>
                <tr class="bg-gray-800 text-white">
                    <th class="px-4 py-2 text-left">Card Number</th>
                    <th class="px-4 py-2 text-left">Expiry Date</th>
                    <th class="px-4 py-2 text-left">Card Type</th>
                    <th class="px-4 py-2 text-center">Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr class="border-b">
                    <td class="px-4 py-2">**** **** **** 1234</td>
                    <td class="px-4 py-2">12/25</td>
                    <td class="px-4 py-2">Visa</td>
                    <td class="px-4 py-2 text-center">
                        <button onclick="openEditPayment()" class="text-blue-500 hover:text-blue-700 mr-2"><i class="fas fa-edit"></i></button>
                        <button class="text-red-500 hover:text-red-700"><i class="fas fa-trash"></i></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>

</div>

<!-- Edit Profile Modal -->
<div id="editProfileModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex justify-center items-center">
    <div class="bg-white p-6 rounded shadow-lg w-96">
        <h2 class="text-xl font-semibold mb-4">Edit Profile</h2>
        <input type="text" id="editName" class="w-full border px-3 py-2 mb-2" placeholder="Full Name">
        <input type="email" id="editEmail" class="w-full border px-3 py-2 mb-2" placeholder="Email">
        <input type="tel" id="editPhone" class="w-full border px-3 py-2 mb-2" placeholder="Phone">
        <input type="text" id="editAddress" class="w-full border px-3 py-2 mb-4" placeholder="Address">
        <div class="flex justify-end">
            <button onclick="closeEditProfile()" class="bg-gray-400 px-4 py-2 rounded mr-2">Cancel</button>
            <button class="bg-blue-500 px-4 py-2 text-white rounded">Save</button>
        </div>
    </div>
</div>

<!-- Add Payment Modal -->
<div id="addPaymentModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex justify-center items-center">
    <div class="bg-white p-6 rounded shadow-lg w-96">
        <h2 class="text-xl font-semibold mb-4">Add Payment Method</h2>
        <form action="savePayment" method="post" class="flex flex-col space-y-3">
            <input type="text" name="cardHolder" class="w-full border px-3 py-2" placeholder="Cardholder Name" required>
            <input type="text" name="cardNumber" class="w-full border px-3 py-2" placeholder="Card Number" required>
            <input type="text" name="cardType" class="w-full border px-3 py-2" placeholder="Card Type" required>
            <input type="text" name="expiryDate" class="w-full border px-3 py-2" placeholder="Expiry Date (MM/YY)" required>
            <input type="text" name="cvv" class="w-full border px-3 py-2" placeholder="CVV" required>
            <div class="flex justify-end pt-2">
                <button type="button" onclick="closePaymentForm()" class="bg-gray-400 px-4 py-2 rounded mr-2">Cancel</button>
                <button type="submit" class="bg-blue-500 px-4 py-2 text-white rounded">Add</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openEditProfile() {
        document.getElementById('editProfileModal').classList.remove('hidden');
    }

    function closeEditProfile() {
        document.getElementById('editProfileModal').classList.add('hidden');
    }

    function openPaymentForm() {
        document.getElementById('addPaymentModal').classList.remove('hidden');
    }

    function closePaymentForm() {
        document.getElementById('addPaymentModal').classList.add('hidden');
    }

    window.onload = function () {
        fetch("getProfile")
            .then(response => {
                if (!response.ok) throw new Error("Failed to load profile");
                return response.json();
            })
            .then(data => {
                document.getElementById("name").value = data.username;
                document.getElementById("email").value = data.email;
                document.getElementById("editName").value = data.username;
                document.getElementById("editEmail").value = data.email;

                // Set placeholders or "N/A" for missing data
                document.getElementById("phone").value = "N/A";
                document.getElementById("address").value = "N/A";
                document.getElementById("editPhone").value = "";
                document.getElementById("editAddress").value = "";
            })
            .catch(error => {
                console.error("Profile fetch error:", error);
            });
    };
</script>


</body>
</html>
