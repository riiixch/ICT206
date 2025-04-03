<?php
require_once 'config.php';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['action'])) {
        try {
            if ($_POST['action'] === 'create') {
                $stmt = $pdo->prepare("INSERT INTO places (name, description, image, location) VALUES (?, ?, ?, ?)");
                $stmt->execute([$_POST['name'], $_POST['description'], $_POST['image'], $_POST['location']]);
            } elseif ($_POST['action'] === 'update') {
                $stmt = $pdo->prepare("UPDATE places SET name = ?, description = ?, image = ?, location = ? WHERE id = ?");
                $stmt->execute([$_POST['name'], $_POST['description'], $_POST['image'], $_POST['location'], $_POST['id']]);
            }
            header('Location: index.php');
            exit;
        } catch (PDOException $e) {
            $error = "Error: " . $e->getMessage();
        }
    }
}

// Handle delete
if (isset($_GET['delete'])) {
    try {
        $stmt = $pdo->prepare("DELETE FROM places WHERE id = ?");
        $stmt->execute([$_GET['delete']]);
        header('Location: index.php');
        exit;
    } catch (PDOException $e) {
        $error = "Error: " . $e->getMessage();
    }
}

// Fetch all places
try {
    $stmt = $pdo->prepare("SELECT * FROM places");
    $stmt->execute();
    $places = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $error = "Error fetching data: " . $e->getMessage();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourism Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }
        .thead-dark {
            background: #2c3e50;
            color: white;
        }
        .btn-custom {
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
        }
        .modal-content {
            border-radius: 15px;
        }
        .img-preview {
            border-radius: 8px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="mb-0" style="color: #2c3e50;">
                    <i class="fas fa-map-marked-alt me-2"></i>Tourism Places
                </h1>
                <button type="button" class="btn btn-primary btn-custom" 
                        data-bs-toggle="modal" data-bs-target="#addModal">
                    <i class="fas fa-plus me-2"></i>Add New Place
                </button>
            </div>

            <?php if (isset($error)): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><?php echo $error; ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <!-- Places Table -->
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                            <th><i class="fas fa-landmark me-1"></i>Name</th>
                            <th><i class="fas fa-info-circle me-1"></i>Description</th>
                            <th><i class="fas fa-image me-1"></i>Image</th>
                            <th><i class="fas fa-map-marker-alt me-1"></i>Location</th>
                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($places as $place): ?>
                            <tr>
                                <td><?php echo $place['id']; ?></td>
                                <td><?php echo $place['name']; ?></td>
                                <td><?php echo substr($place['description'], 0, 50) . (strlen($place['description']) > 50 ? '...' : ''); ?></td>
                                <td>
                                    <img src="./images/<?php echo $place['image']; ?>" 
                                         alt="<?php echo $place['name']; ?>" 
                                         class="img-preview" 
                                         width="60" height="40">
                                </td>
                                <td><?php echo $place['location']; ?></td>
                                <td>
                                    <button class="btn btn-warning btn-sm btn-custom edit-btn me-1" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#editModal"
                                            data-id="<?php echo $place['id']; ?>"
                                            data-name="<?php echo $place['name']; ?>"
                                            data-description="<?php echo $place['description']; ?>"
                                            data-image="<?php echo $place['image']; ?>"
                                            data-location="<?php echo $place['location']; ?>">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <a href="?delete=<?php echo $place['id']; ?>" 
                                       class="btn btn-danger btn-sm btn-custom" 
                                       onclick="return confirm('Are you sure you want to delete <?php echo $place['name']; ?>?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Modal -->
    <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form method="POST">
                    <div class="modal-header" style="background: #2c3e50; color: white;">
                        <h5 class="modal-title" id="addModalLabel">
                            <i class="fas fa-plus me-2"></i>Add New Place
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Image Filename</label>
                            <input type="text" class="form-control" name="image" placeholder="e.g., koh_samet.jpg">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Location (lat, lng)</label>
                            <input type="text" class="form-control" name="location" placeholder="e.g., 12.5657, 101.4500">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Close
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form method="POST">
                    <div class="modal-header" style="background: #2c3e50; color: white;">
                        <h5 class="modal-title" id="editModalLabel">
                            <i class="fas fa-edit me-2"></i>Edit Place
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="edit-id">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="name" id="edit-name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Description</label>
                            <textarea class="form-control" name="description" id="edit-description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Image Filename</label>
                            <input type="text" class="form-control" name="image" id="edit-image">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Location (lat, lng)</label>
                            <input type="text" class="form-control" name="location" id="edit-location">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-1"></i>Close
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Save changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('edit-id').value = this.dataset.id;
                document.getElementById('edit-name').value = this.dataset.name;
                document.getElementById('edit-description').value = this.dataset.description;
                document.getElementById('edit-image').value = this.dataset.image;
                document.getElementById('edit-location').value = this.dataset.location;
            });
        });
    </script>
</body>
</html>