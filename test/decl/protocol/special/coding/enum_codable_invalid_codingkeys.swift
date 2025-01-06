// RUN: %target-typecheck-verify-swift -verify-ignore-unknown

// Enums with a CodingKeys entity which is not a type should not derive
// conformance.
enum InvalidCodingKeys1 : Codable { // expected-error {{type 'InvalidCodingKeys1' does not conform to protocol 'Decodable'}}
  // expected-error@-1 {{type 'InvalidCodingKeys1' does not conform to protocol 'Encodable'}}
  // expected-error@-2 {{cannot automatically synthesize 'Encodable' conformance for empty enum 'InvalidCodingKeys1'}}
  // expected-error@-3 {{cannot automatically synthesize 'Decodable' conformance for empty enum 'InvalidCodingKeys1'}}
  static let CodingKeys = 5 // expected-note {{cannot automatically synthesize 'Decodable' because 'CodingKeys' is not an enum}}
  // expected-note@-1 {{cannot automatically synthesize 'Encodable' because 'CodingKeys' is not an enum}}
}

// Enums with a CodingKeys entity which does not conform to CodingKey should
// not derive conformance.
enum InvalidCodingKeys2 : Codable { // expected-error {{type 'InvalidCodingKeys2' does not conform to protocol 'Decodable'}}
  // expected-error@-1 {{type 'InvalidCodingKeys2' does not conform to protocol 'Encodable'}}
  // expected-error@-2 {{cannot automatically synthesize 'Encodable' conformance for empty enum 'InvalidCodingKeys2'}}
  // expected-error@-3 {{cannot automatically synthesize 'Decodable' conformance for empty enum 'InvalidCodingKeys2'}}
  enum CodingKeys {} // expected-note {{cannot automatically synthesize 'Decodable' because 'CodingKeys' does not conform to CodingKey}}
  // expected-note@-1 {{cannot automatically synthesize 'Encodable' because 'CodingKeys' does not conform to CodingKey}}
}

// Enums with a CodingKeys entity which is not an enum should not derive
// conformance.
enum InvalidCodingKeys3 : Codable { // expected-error {{type 'InvalidCodingKeys3' does not conform to protocol 'Decodable'}}
  // expected-error@-1 {{type 'InvalidCodingKeys3' does not conform to protocol 'Encodable'}}
  // expected-error@-2 {{cannot automatically synthesize 'Decodable' conformance for empty enum 'InvalidCodingKeys3'}}
  // expected-error@-3 {{cannot automatically synthesize 'Encodable' conformance for empty enum 'InvalidCodingKeys3'}}
  struct CodingKeys : CodingKey { // expected-note {{cannot automatically synthesize 'Decodable' because 'CodingKeys' is not an enum}}
    // expected-note@-1 {{cannot automatically synthesize 'Encodable' because 'CodingKeys' is not an enum}}
      var stringValue: String
      init?(stringValue: String) {
          self.stringValue = stringValue
          self.intValue = nil
      }

      var intValue: Int?
      init?(intValue: Int) {
          self.stringValue = "\(intValue)"
          self.intValue = intValue
      }
  }
}
