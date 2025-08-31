package com.commerce.proxiia.repositories;

import com.commerce.proxiia.model.Sale;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface SaleRepository extends JpaRepository<Sale, UUID> {
    List<Sale> findByProductId(UUID productId);
    List<Sale> findBySku(String sku);
    List<Sale> findByStatus(String status);
    List<Sale> findBySaleDateBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    @Query("SELECT s FROM Sale s WHERE s.saleDate >= :startDate")
    List<Sale> findRecentSales(@Param("startDate") LocalDateTime startDate);
}


