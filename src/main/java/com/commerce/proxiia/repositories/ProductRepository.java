package com.commerce.proxiia.repositories;

import com.commerce.proxiia.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> {
    Optional<Product> findBySku(String sku);
    boolean existsBySku(String sku);
    List<Product> findByStatus(String status);
    
    @Query("SELECT p FROM Product p WHERE p.name LIKE %:searchTerm% OR p.description LIKE %:searchTerm% OR p.brand LIKE %:searchTerm%")
    List<Product> searchProducts(@Param("searchTerm") String searchTerm);
    
    @Query("SELECT p FROM Product p JOIN Inventory i ON p.id = i.productId WHERE i.quantity <= i.reorderPoint")
    List<Product> findProductsNeedingReorder();
    
    List<Product> findByCategoryId(String categoryId);
    List<Product> findByBrand(String brand);
    List<Product> findByActiveTrue();
}


