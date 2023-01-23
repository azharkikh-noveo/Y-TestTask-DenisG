//
//  DependencyContainerSpec.swift
//  TMCoreTests
//

import Foundation
import Nimble
import Quick

@testable import TMCore

// MARK: - DependencyContainerSpec

final class DependencyContainerSpec: QuickSpec {
    override func spec() {
        describe("DependencyContainer") {
            var sut: DependencyContainer!
            
            afterEach {
                sut = nil
            }
            
            // MARK: - App env
            
            context("in app env") {
                beforeEach {
                    sut = DependencyContainer(inTests: false)
                }
                
                context("bind singletone") {
                    var sharedInstance: EntityType!
                    var getEntity: (() -> EntityType)!
                    
                    beforeEach {
                        sharedInstance = Entity()
                        getEntity = sut.bind(
                            EntityType.self,
                            to: { sharedInstance }
                        )
                    }
                    
                    it("returns same instances") {
                        let instance1 = getEntity()
                        let instance2 = getEntity()
                        
                        expect(instance1 === sharedInstance).to(beTrue())
                        expect(instance2 === sharedInstance).to(beTrue())
                    }
                }
                
                context("bind instance creation") {
                    var getEntity: (() -> EntityType)!
                    
                    beforeEach {
                        getEntity = sut.bind(
                            EntityType.self,
                            to: { Entity() }
                        )
                    }
                    
                    it("returns different instances") {
                        let instance1 = getEntity()
                        let instance2 = getEntity()
                        
                        expect(instance1 === instance2).to(beFalse())
                    }
                }
            }
            
            // MARK: - Test env
            
            context("in test env") {
                beforeEach {
                    sut = DependencyContainer()
                }
                
                context("mock and then bind") {
                    var mockedInstance: EntityMock!
                    var getEntity: (() -> EntityType)!
                    
                    beforeEach {
                        mockedInstance = sut.mock(
                            EntityType.self,
                            to: EntityMock()
                        )
                        
                        getEntity = sut.bind(
                            EntityType.self,
                            to: { Entity() }
                        )
                    }
                    
                    it("bind returns mocked instance") {
                        expect(getEntity()).to(beAnInstanceOf(EntityMock.self))
                        expect(getEntity() === mockedInstance).to(beTrue())
                    }
                    
                    context("unmock") {
                        beforeEach {
                            sut.unmock()
                        }
                        
                        it("throws an assertion if accessed") {
                            expect(getEntity()).to(throwAssertion())
                        }
                    }
                }
                
                context("bind and then mock") {
                    var mockedInstance: EntityMock!
                    var getEntity: (() -> EntityType)!
                    
                    beforeEach {
                        getEntity = sut.bind(
                            EntityType.self,
                            to: { Entity() }
                        )
                        
                        mockedInstance = sut.mock(
                            EntityType.self,
                            to: EntityMock()
                        )
                    }
                    
                    it("bind returns mocked instance") {
                        expect(getEntity()).to(beAnInstanceOf(EntityMock.self))
                        expect(getEntity() === mockedInstance).to(beTrue())
                    }
                    
                    context("unmock") {
                        beforeEach {
                            sut.unmock()
                        }
                        
                        it("throws an assertion if accessed") {
                            expect(getEntity()).to(throwAssertion())
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Entities

private protocol EntityType: AnyObject {}
private final class Entity: EntityType {}
private final class EntityMock: EntityType {}
