<footer>
    <div class="footer-wrap">
        <div>
            <h4>Pilgrim Project</h4>
            <p>Building harmony by showcasing sacred places of every faith. Connecting humanity through shared spiritual heritage.</p>
        </div>
        
        <div>
            <h4>Quick Links</h4>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/services">Services</a>
            <a href="<%=request.getContextPath()%>/aboutus">About Us</a>
            <a href="<%=request.getContextPath()%>/contactus">Contact Us</a>
        </div>
        
        <div>
            <h4>Religions</h4>
            <a href="#">Hinduism</a>
            <a href="#">Christianity</a>
            <a href="#">Islam</a>
            <a href="#">Buddhism</a>
            <a href="#">Sikhism</a>
            <a href="#">Judaism</a>
        </div>
        
        <div>
            <h4>Legal</h4>
            <a href="<%=request.getContextPath()%>/privacy">Privacy Policy</a>
            <a href="<%=request.getContextPath()%>/terms">Terms & Conditions</a>
            <a href="#">Accessibility</a>
            <a href="#">Partnerships</a>
        </div>
    </div>
    
    <div class="footer-bottom">
        © <%= java.time.Year.now() %> Pilgrim Project. All Rights Reserved. | Made with <i class="fa-solid fa-heart" style="color:#d4af37;"></i> for humanity
    </div>
</footer>
