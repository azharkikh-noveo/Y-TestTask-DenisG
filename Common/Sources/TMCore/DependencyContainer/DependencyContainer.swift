//
//  DependencyContainer.swift
//  TMCore
//

import Foundation

public let dependencyContainer = DependencyContainer()

public final class DependencyContainer {
    
    public typealias Storage = [ObjectIdentifier: () -> Any]
    public typealias DependencyResolver<T> = () -> T
    
    private var storage: Storage = [:]
    private let serialQueue = DispatchQueue(label: "com.dgaskov.TrendingMovies.DependencyContainerQueue")
    
    #if DEBUG
    
    private var mockStorage: Storage = [:]
    private let inTests: Bool
    
    // Externally setting `inTests` might be useful in DependencyContainerSpec,
    // when we want to simulate "in app" environment
    init(inTests: Bool = DependencyContainer.isInTestEnv) {
        self.inTests = inTests
    }
    
    #else
    
    init() {}
    
    #endif
}

public extension DependencyContainer {
    
    func bind<DependencyType>(
        _ dependencyType: DependencyType.Type,
        to makeDependency: @escaping DependencyResolver<DependencyType>
    ) -> DependencyResolver<DependencyType> {
        let key = ObjectIdentifier(dependencyType)
        
        serialQueue.sync {
            storage[key] = makeDependency
        }
        
        return {
            var dependencyResolver: (() -> Any)?
            self.serialQueue.sync {
                dependencyResolver = self.lookupStorage[key]
            }
            
            guard let dependency = dependencyResolver?() else {
                assertionFailure("Dependency of type \(dependencyType) not found")
                
                // In release, it's better to create dependency again instead of crash.
                // In debug (or tests) it's better to crash instead
                return makeDependency()
            }
            
            guard let typedDependency = dependency as? DependencyType else {
                assertionFailure("Could not resolve \(type(of: dependency)) as \(DependencyType.self)")
                
                // In release, it's better to create dependency again instead of crash.
                // In debug (or tests) it's better to crash instead
                return makeDependency()
            }
            
            return typedDependency
        }
    }
    
    private var lookupStorage: Storage {
        #if DEBUG
        return self.inTests ? self.mockStorage : self.storage
        #else
        return self.storage
        #endif
    }
}

// MARK: - TestHelpers

#if DEBUG

public extension DependencyContainer {
    
    private static var isInTestEnv: Bool {
        let testSessionIdIsEmpty = ProcessInfo.processInfo.environment["XCTestSessionIdentifier"]?.isEmpty ?? true
        return !testSessionIdIsEmpty
    }
    
    func mock<DependencyType, DependencyInstance>(
        _ dependencyType: DependencyType.Type,
        to mockInstance: DependencyInstance
    ) -> DependencyInstance {
        let key = ObjectIdentifier(dependencyType)
        guard let dependency = mockInstance as? DependencyType else {
            // It's better to immediately crash in tests, instead of running further tests
            fatalError("Could not resolve \(type(of: mockInstance)) as \(DependencyType.self)")
        }
        serialQueue.sync {
            mockStorage[key] = { dependency }
        }
        return mockInstance
    }
    
    func unmock() {
        serialQueue.sync {
            mockStorage.removeAll()
        }
    }
}

#endif
