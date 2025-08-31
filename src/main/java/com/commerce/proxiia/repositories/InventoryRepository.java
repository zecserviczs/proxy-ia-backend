package com.commerce.proxiia.repositories;

import com.commerce.proxiia.model.Inventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, UUID> {
    Optional<Inventory> findBySku(String sku);
    Optional<Inventory> findByProductId(UUID productId);
    List<Inventory> findByStatus(String status);
    List<Inventory> findByWarehouseCode(String warehouseCode);
    
    @Query("SELECT i FROM Inventory i WHERE i.quantity <= i.reorderPoint")
    List<Inventory> findLowStockItems();
    
    @Query("SELECT i FROM Inventory i WHERE i.quantity = 0")
    List<Inventory> findOutOfStockItems();
    
    @Query("SELECT i FROM Inventory i WHERE i.quantity > i.maxStock")
    List<Inventory> findOverstockedItems();
}


