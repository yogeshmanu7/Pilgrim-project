        </div>
        <!-- End Content Area -->
        
        <!-- Footer -->
        <footer class="text-center py-4" style="color: var(--text-secondary); border-top: 1px solid var(--border-color);">
            <p class="mb-0">
                <i class="fas fa-globe-americas me-2" style="color: var(--primary-teal);"></i>
                &copy; 2024 Global Pilgrim - Connecting Faiths Worldwide. All rights reserved.
            </p>
        </footer>
    </main>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom Scripts -->
    <script>
        // Mobile sidebar toggle
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.querySelector('.sidebar');
            const toggleBtn = document.querySelector('.sidebar-toggle');
            
            if (toggleBtn) {
                toggleBtn.addEventListener('click', function() {
                    sidebar.classList.toggle('show');
                });
            }
        });
    </script>
</body>
</html>
