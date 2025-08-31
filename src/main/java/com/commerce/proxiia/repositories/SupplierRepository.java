package com.commerce.proxiia.repositories;

import com.commerce.proxiia.model.Supplier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface SupplierRepository extends JpaRepository<Supplier, UUID> {
    Optional<Supplier> findByName(String name);
    List<Supplier> findByStatus(String status);
    List<Supplier> findByCountry(String country);
}


