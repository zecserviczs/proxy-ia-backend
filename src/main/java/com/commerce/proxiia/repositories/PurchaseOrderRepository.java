package com.commerce.proxiia.repositories;

import com.commerce.proxiia.model.PurchaseOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface PurchaseOrderRepository extends JpaRepository<PurchaseOrder, UUID> {
    List<PurchaseOrder> findBySupplierId(UUID supplierId);
    List<PurchaseOrder> findByProductId(UUID productId);
    List<PurchaseOrder> findByStatus(String status);
    List<PurchaseOrder> findByOrderDateBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    @Query("SELECT po FROM PurchaseOrder po WHERE po.expectedDeliveryDate <= :date AND po.status = 'PENDING'")
    List<PurchaseOrder> findOverdueOrders(@Param("date") LocalDateTime date);
}


