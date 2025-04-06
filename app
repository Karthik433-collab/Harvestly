import { useState } from 'react'
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "/components/ui/card"
import { Button } from "/components/ui/button"
import { Input } from "/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "/components/ui/select"
import { Shield, Users, Home, Search, Star, ArrowRight } from "lucide-react"

// Expanded crop data
const crops = [
  { id: 1, name: "Wheat", season: "Winter/Spring", yield: "50-80 bushels/acre" },
  { id: 2, name: "Corn", season: "Summer", yield: "150-200 bushels/acre" },
  { id: 3, name: "Soybeans", season: "Summer", yield: "40-60 bushels/acre" },
  { id: 4, name: "Rice", season: "Summer", yield: "6,000-8,000 lbs/acre" },
  { id: 5, name: "Cotton", season: "Summer", yield: "800-1,200 lbs/acre" },
  { id: 6, name: "Barley", season: "Winter/Spring", yield: "60-100 bushels/acre" },
  { id: 7, name: "Oats", season: "Spring", yield: "80-120 bushels/acre" },
  { id: 8, name: "Canola", season: "Winter/Spring", yield: "1,500-2,500 lbs/acre" },
  { id: 9, name: "Sunflower", season: "Summer", yield: "1,500-2,500 lbs/acre" },
  { id: 10, name: "Sorghum", season: "Summer", yield: "80-120 bushels/acre" }
]

// Enhanced company data with more offers
const companies = [
  {
    id: 1,
    name: "AgriCorp",
    rating: 4.5,
    offers: [
      { cropId: 1, crop: "Wheat", price: 5.20, terms: "Cash on delivery", rating: 4.3 },
      { cropId: 2, crop: "Corn", price: 4.80, terms: "30-day payment", rating: 4.1 },
      { cropId: 6, crop: "Barley", price: 3.90, terms: "Contract pricing", rating: 4.0 }
    ]
  },
  {
    id: 2,
    name: "FarmFresh Co.",
    rating: 4.2,
    offers: [
      { cropId: 3, crop: "Soybeans", price: 12.50, terms: "Immediate payment", rating: 4.4 },
      { cropId: 8, crop: "Canola", price: 15.20, terms: "Seasonal contract", rating: 4.2 },
      { cropId: 5, crop: "Cotton", price: 0.85, terms: "Forward contract", rating: 3.9 }
    ]
  },
  {
    id: 3,
    name: "Harvest Partners",
    rating: 4.7,
    offers: [
      { cropId: 4, crop: "Rice", price: 0.18, terms: "Flexible payment", rating: 4.6 },
      { cropId: 7, crop: "Oats", price: 3.40, terms: "Cash advance", rating: 4.3 },
      { cropId: 9, crop: "Sunflower", price: 0.28, terms: "Deferred payment", rating: 4.5 }
    ]
  },
  {
    id: 4,
    name: "Golden Fields",
    rating: 4.3,
    offers: [
      { cropId: 10, crop: "Sorghum", price: 5.50, terms: "Cash on delivery", rating: 4.2 },
      { cropId: 2, crop: "Corn", price: 4.95, terms: "15-day payment", rating: 4.0 },
      { cropId: 3, crop: "Soybeans", price: 12.75, terms: "Immediate payment", rating: 4.3 }
    ]
  }
]

// Enhanced financial products
const financialProducts = [
  {
    type: "loan",
    title: "Seasonal Operating Loan",
    description: "Low-interest loans to cover planting and harvesting costs",
    details: "Up to $250,000 with 3.5% APR. Flexible repayment terms aligned with harvest cycles.",
    requirements: "2 years farming experience, land ownership/lease documentation"
  },
  {
    type: "loan",
    title: "Equipment Financing",
    description: "Finance for new or used farm equipment",
    details: "Terms from 3-7 years. Competitive rates starting at 4.2% APR. Up to 90% financing available.",
    requirements: "Good credit history, equipment quote/invoice"
  },
  {
    type: "insurance",
    title: "Multi-Peril Crop Insurance",
    description: "Protection against weather, disease, and price drops",
    details: "Covers up to 85% of your average yield. Premiums vary by crop and coverage level.",
    requirements: "Production history for 4-10 years depending on crop"
  },
  {
    type: "insurance",
    title: "Revenue Protection",
    description: "Guarantees a portion of your expected revenue",
    details: "Combines yield and price protection. Helps manage both production and market risks.",
    requirements: "Production history, projected yields"
  }
]

// Enhanced technology data
const technologies = [
  {
    title: "Precision Planting",
    description: "Optimize seed placement for maximum yield",
    details: "Uses GPS and sensors to plant seeds at optimal depth and spacing. Can increase yields by 5-10% while reducing seed waste.",
    benefits: ["Higher yields", "Reduced input costs", "Better stand establishment"],
    cost: "$15,000-$50,000 depending on system size"
  },
  {
    title: "Soil Moisture Sensors",
    description: "Monitor soil conditions in real-time",
    details: "Wireless sensors provide data on moisture levels at different depths, helping optimize irrigation and reduce water usage by up to 25%.",
    benefits: ["Water conservation", "Improved crop health", "Reduced pumping costs"],
    cost: "$500-$2,000 per field"
  },
  {
    title: "Drone Scouting",
    description: "Aerial imaging for crop health assessment",
    details: "Drones with multispectral cameras can identify pest damage, nutrient deficiencies, and irrigation issues before they're visible to the naked eye.",
    benefits: ["Early problem detection", "Reduced scouting time", "Targeted treatments"],
    cost: "$5,000-$15,000 for complete system"
  }
]

export default function HarvestlyAdvanced() {
  const [activeTab, setActiveTab] = useState('companies')
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedCrop, setSelectedCrop] = useState('all')
  const [selectedCompany, setSelectedCompany] = useState(null)
  const [selectedCropDetail, setSelectedCropDetail] = useState(null)

  // Filter companies based on search and crop selection
  const filteredCompanies = companies.filter(company => {
    const matchesSearch = company.name.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesCrop = selectedCrop === 'all' || 
      company.offers.some(offer => offer.cropId === parseInt(selectedCrop))
    return matchesSearch && matchesCrop
  })

  // Get all offers for price comparison
  const allOffers = companies.flatMap(company => 
    company.offers.map(offer => ({
      ...offer,
      companyName: company.name,
      companyRating: company.rating
    }))
  )

  // Filter offers by crop if selected
  const offersToCompare = selectedCrop === 'all' 
    ? allOffers 
    : allOffers.filter(offer => offer.cropId === parseInt(selectedCrop))

  // Group offers by crop for comparison
  const offersByCrop = crops.map(crop => {
    const cropOffers = allOffers.filter(offer => offer.cropId === crop.id)
    return {
      crop: crop.name,
      offers: cropOffers,
      avgPrice: cropOffers.length > 0 
        ? (cropOffers.reduce((sum, offer) => sum + offer.price, 0) / cropOffers.length).toFixed(2)
        : null
    }
  }).filter(item => item.offers.length > 0)

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-green-800 text-white shadow-lg">
        <div className="container mx-auto px-4 py-6">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-bold">Harvestly Pro</h1>
              <p className="text-green-200">Advanced farming marketplace</p>
            </div>
            <div className="flex items-center space-x-4">
              <Button variant="secondary" className="bg-green-700 hover:bg-green-600">
                Farmer Dashboard
              </Button>
              <Button variant="secondary" className="bg-green-700 hover:bg-green-600">
                My Account
              </Button>
            </div>
          </div>
        </div>
      </header>

      {/* Navigation Tabs */}
      <div className="container mx-auto px-4 py-4 bg-white shadow-sm">
        <div className="flex border-b border-gray-200">
          <button
            onClick={() => {
              setActiveTab('companies')
              setSelectedCompany(null)
              setSelectedCropDetail(null)
            }}
            className={`px-4 py-2 font-medium ${activeTab === 'companies' ? 'text-green-700 border-b-2 border-green-700' : 'text-gray-500'}`}
          >
            <div className="flex items-center">
              <Users className="mr-2 h-4 w-4" />
              Market Offers
            </div>
          </button>
          <button
            onClick={() => {
              setActiveTab('finance')
              setSelectedCompany(null)
              setSelectedCropDetail(null)
            }}
            className={`px-4 py-2 font-medium ${activeTab === 'finance' ? 'text-green-700 border-b-2 border-green-700' : 'text-gray-500'}`}
          >
            <div className="flex items-center">
              <Shield className="mr-2 h-4 w-4" />
              Finance Center
            </div>
          </button>
          <button
            onClick={() => {
              setActiveTab('tech')
              setSelectedCompany(null)
              setSelectedCropDetail(null)
            }}
            className={`px-4 py-2 font-medium ${activeTab === 'tech' ? 'text-green-700 border-b-2 border-green-700' : 'text-gray-500'}`}
          >
            <div className="flex items-center">
              <Home className="mr-2 h-4 w-4" />
              Farm Tech Hub
            </div>
          </button>
          <button
            onClick={() => {
              setActiveTab('crops')
              setSelectedCompany(null)
              setSelectedCropDetail(null)
            }}
            className={`px-4 py-2 font-medium ${activeTab === 'crops' ? 'text-green-700 border-b-2 border-green-700' : 'text-gray-500'}`}
          >
            <div className="flex items-center">
              <Search className="mr-2 h-4 w-4" />
              Crop Encyclopedia
            </div>
          </button>
        </div>
      </div>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-6">
        {activeTab === 'companies' && !selectedCompany && (
          <div>
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
              <div>
                <h2 className="text-2xl font-semibold">Marketplace</h2>
                <p className="text-gray-600">Compare offers from agricultural buyers</p>
              </div>
              <div className="flex flex-col sm:flex-row gap-3 w-full md:w-auto">
                <div className="relative w-full">
                  <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
                  <Input
                    placeholder="Search companies..."
                    className="pl-10 w-full"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                  />
                </div>
                <Select value={selectedCrop} onValueChange={setSelectedCrop}>
                  <SelectTrigger className="w-[180px]">
                    <SelectValue placeholder="Filter by crop" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Crops</SelectItem>
                    {crops.map(crop => (
                      <SelectItem key={crop.id} value={crop.id.toString()}>
                        {crop.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            {offersByCrop.length > 0 && (
              <div className="mb-8">
                <h3 className="text-lg font-medium mb-3">Price Comparison by Crop</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">
                  {offersByCrop.map((item, index) => (
                    <Card key={index} className="hover:shadow-md transition-shadow cursor-pointer"
                      onClick={() => setSelectedCropDetail(item.crop)}>
                      <CardHeader>
                        <CardTitle className="text-lg">{item.crop}</CardTitle>
                        <CardDescription>Avg: ${item.avgPrice}</CardDescription>
                      </CardHeader>
                      <CardContent>
                        <div className="flex justify-between items-center">
                          <span className="text-sm text-gray-500">Offers:</span>
                          <span className="font-medium">{item.offers.length}</span>
                        </div>
                        <div className="flex justify-between items-center mt-2">
                          <span className="text-sm text-gray-500">Range:</span>
                          <span className="font-medium">
                            ${Math.min(...item.offers.map(o => o.price)).toFixed(2)} - 
                            ${Math.max(...item.offers.map(o => o.price)).toFixed(2)}
                          </span>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              </div>
            )}

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {filteredCompanies.map(company => (
                <Card key={company.id} className="hover:shadow-lg transition-shadow">
                  <CardHeader>
                    <div className="flex justify-between items-start">
                      <CardTitle>{company.name}</CardTitle>
                      <div className="flex items-center bg-green-100 text-green-800 px-2 py-1 rounded-full">
                        <Star className="h-4 w-4 mr-1" />
                        <span className="text-sm font-medium">{company.rating.toFixed(1)}</span>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <h3 className="font-medium mb-3">Current Offers</h3>
                    <div className="space-y-3">
                      {company.offers
                        .filter(offer => selectedCrop === 'all' || offer.cropId === parseInt(selectedCrop))
                        .map((offer, index) => (
                          <div key={index} className="border-l-4 border-green-200 pl-3 py-2">
                            <div className="flex justify-between items-start">
                              <div>
                                <p className="font-medium">{offer.crop}</p>
                                <p className="text-green-700 text-lg font-semibold">${offer.price.toFixed(2)}</p>
                              </div>
                              <div className="flex items-center">
                                <Star className="h-3 w-3 text-yellow-500 mr-1" />
                                <span className="text-xs text-gray-500">{offer.rating.toFixed(1)}</span>
                              </div>
                            </div>
                            <p className="text-sm text-gray-500 mt-1">{offer.terms}</p>
                          </div>
                        ))}
                    </div>
                  </CardContent>
                  <CardFooter>
                    <Button 
                      variant="outline" 
                      className="w-full"
                      onClick={() => setSelectedCompany(company)}
                    >
                      View All Details
                    </Button>
                  </CardFooter>
                </Card>
              ))}
            </div>

            {filteredCompanies.length === 0 && (
              <div className="text-center py-12">
                <p className="text-gray-500">No companies match your search criteria</p>
                <Button 
                  variant="ghost" 
                  className="mt-4"
                  onClick={() => {
                    setSearchTerm('')
                    setSelectedCrop('all')
                  }}
                >
                  Clear filters
                </Button>
              </div>
            )}
          </div>
        )}

        {activeTab === 'companies' && selectedCompany && (
          <div>
            <Button 
              variant="ghost" 
              className="mb-6" 
              onClick={() => setSelectedCompany(null)}
            >
              <ArrowRight className="h-4 w-4 mr-2 transform rotate-180" />
              Back to Marketplace
            </Button>

            <Card>
              <CardHeader>
                <div className="flex justify-between items-start">
                  <div>
                    <CardTitle>{selectedCompany.name}</CardTitle>
                    <div className="flex items-center mt-2">
                      {[...Array(5)].map((_, i) => (
                        <Star
                          key={i}
                          className={`h-5 w-5 ${i < Math.floor(selectedCompany.rating) ? 'fill-yellow-400 text-yellow-400' : 'text-gray-300'}`}
                        />
                      ))}
                      <span className="ml-2 text-gray-600">{selectedCompany.rating.toFixed(1)}</span>
                    </div>
                  </div>
                  <Button variant="secondary">Contact Company</Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <h3 className="font-medium text-lg mb-4">All Offers</h3>
                    <div className="space-y-4">
                      {selectedCompany.offers.map((offer, index) => (
                        <div key={index} className="border rounded-lg p-4 hover:bg-gray-50">
                          <div className="flex justify-between items-start">
                            <div>
                              <p className="font-medium">{offer.crop}</p>
                              <p className="text-green-700 text-xl font-semibold">${offer.price.toFixed(2)}</p>
                            </div>
                            <div className="flex items-center">
                              <Star className="h-4 w-4 text-yellow-500 mr-1" />
                              <span className="text-sm text-gray-500">{offer.rating.toFixed(1)}</span>
                            </div>
                          </div>
                          <p className="text-sm text-gray-500 mt-2">{offer.terms}</p>
                          <div className="mt-3 flex justify-between items-center">
                            <span className="text-xs text-gray-400">Offer ID: {selectedCompany.id}-{offer.cropId}</span>
                            <Button variant="outline" size="sm">
                              View Details
                            </Button>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                  <div>
                    <h3 className="font-medium text-lg mb-4">Company Information</h3>
                    <div className="space-y-4">
                      <div className="border rounded-lg p-4">
                        <h4 className="font-medium mb-2">Payment Terms</h4>
                        <ul className="list-disc list-inside text-sm text-gray-700 space-y-1">
                          <li>Net 30 days for most contracts</li>
                          <li>Immediate payment available for premium members</li>
                          <li>Seasonal payment plans available</li>
                        </ul>
                      </div>
                      <div className="border rounded-lg p-4">
                        <h4 className="font-medium mb-2">Quality Standards</h4>
                        <ul className="list-disc list-inside text-sm text-gray-700 space-y-1">
                          <li>Moisture content ≤ 14% for grains</li>
                          <li>Foreign material ≤ 2%</li>
                          <li>Test weight requirements vary by crop</li>
                        </ul>
                      </div>
                      <div className="border rounded-lg p-4">
                        <h4 className="font-medium mb-2">Delivery Options</h4>
                        <ul className="list-disc list-inside text-sm text-gray-700 space-y-1">
                          <li>Farm pickup available</li>
                          <li>Company transportation for large quantities</li>
                          <li>Grain elevator drop-off points</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {activeTab === 'finance' && (
          <div>
            <h2 className="text-2xl font-semibold mb-2">Finance Center</h2>
            <p className="text-gray-600 mb-6">Explore financing and insurance options for your farm</p>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
              <Card>
                <CardHeader>
                  <CardTitle>Loan Products</CardTitle>
                  <CardDescription>Funding solutions for your operational needs</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {financialProducts.filter(p => p.type === 'loan').map((product, index) => (
                      <div key={index} className="border rounded-lg p-4 hover:bg-gray-50">
                        <h3 className="font-medium">{product.title}</h3>
                        <p className="text-sm text-gray-600 mt-1">{product.description}</p>
                        <div className="mt-3">
                          <p className="text-sm text-gray-700">{product.details}</p>
                          <p className="text-xs text-gray-500 mt-2">
                            <span className="font-medium">Requirements:</span> {product.requirements}
                          </p>
                        </div>
                        <Button variant="outline" size="sm" className="mt-3">
                          Apply Now
                        </Button>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>Insurance Products</CardTitle>
                  <CardDescription>Protect your farm against risks</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {financialProducts.filter(p => p.type === 'insurance').map((product, index) => (
                      <div key={index} className="border rounded-lg p-4 hover:bg-gray-50">
                        <h3 className="font-medium">{product.title}</h3>
                        <p className="text-sm text-gray-600 mt-1">{product.description}</p>
                        <div className="mt-3">
                          <p className="text-sm text-gray-700">{product.details}</p>
                          <p className="text-xs text-gray-500 mt-2">
                            <span className="font-medium">Requirements:</span> {product.requirements}
                          </p>
                        </div>
                        <Button variant="outline" size="sm" className="mt-3">
                          Get Quote
                        </Button>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>Financial Calculator</CardTitle>
                <CardDescription>Estimate payments and returns</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Loan Amount ($)</label>
                    <Input type="number" placeholder="10,000" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Interest Rate (%)</label>
                    <Input type="number" placeholder="4.5" step="0.1" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Term (years)</label>
                    <Input type="number" placeholder="5" />
                  </div>
                </div>
                <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                  <Button className="w-full">Calculate Monthly Payment</Button>
                  <Button variant="outline" className="w-full">
                    Compare Loan Options
                  </Button>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {activeTab === 'tech' && (
          <div>
            <h2 className="text-2xl font-semibold mb-2">Farm Tech Hub</h2>
            <p className="text-gray-600 mb-6">Discover technologies to improve your farm's productivity</p>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {technologies.map((tech, index) => (
                <Card key={index} className="hover:shadow-md transition-shadow">
                  <CardHeader>
                    <CardTitle>{tech.title}</CardTitle>
                    <CardDescription>{tech.description}</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <p className="text-gray-700 mb-4">{tech.details}</p>
                    <div className="mb-4">
                      <h4 className="font-medium mb-2">Key Benefits:</h4>
                      <ul className="list-disc list-inside text-sm text-gray-700 space-y-1">
                        {tech.benefits.map((benefit, i) => (
                          <li key={i}>{benefit}</li>
                        ))}
                      </ul>
                    </div>
                    <p className="text-sm text-gray-600">
                      <span className="font-medium">Estimated Cost:</span> {tech.cost}
                    </p>
                  </CardContent>
                  <CardFooter className="flex justify-between">
                    <Button variant="outline">View Demo</Button>
                    <Button>Contact Supplier</Button>
                  </CardFooter>
                </Card>
              ))}
            </div>

            <Card className="mt-8">
              <CardHeader>
                <CardTitle>Tech Adoption Calculator</CardTitle>
                <CardDescription>Estimate ROI for new technologies</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Technology</label>
                      <Select>
                        <SelectTrigger>
                          <SelectValue placeholder="Select technology" />
                        </SelectTrigger>
                        <SelectContent>
                          {technologies.map((tech, index) => (
                            <SelectItem key={index} value={tech.title}>
                              {tech.title}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Acres Affected</label>
                      <Input type="number" placeholder="100" />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Current Yield (units/acre)</label>
                      <Input type="number" placeholder="150" />
                    </div>
                  </div>
                  <div className="space-y-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Expected Yield Increase (%)</label>
                      <Input type="number" placeholder="5" />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Crop Price ($/unit)</label>
                      <Input type="number" placeholder="4.50" step="0.01" />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 mb-1">Technology Cost ($)</label>
                      <Input type="number" placeholder="15,000" />
                    </div>
                  </div>
                </div>
                <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                  <Button className="w-full">Calculate ROI</Button>
                  <Button variant="outline" className="w-full">
                    Compare Technologies
                  </Button>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {activeTab === 'crops' && (
          <div>
            <h2 className="text-2xl font-semibold mb-2">Crop Encyclopedia</h2>
            <p className="text-gray-600 mb-6">Detailed information about different crops</p>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 mb-8">
              {crops.map(crop => (
                <Card 
                  key={crop.id} 
                  className={`hover:shadow-md transition-shadow cursor-pointer ${selectedCropDetail === crop.name ? 'ring-2 ring-green-500' : ''}`}
                  onClick={() => setSelectedCropDetail(crop.name)}
                >
                  <CardHeader>
                    <CardTitle className="text-lg">{crop.name}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="flex justify-between text-sm text-gray-600">
                      <span>Season:</span>
                      <span className="font-medium">{crop.season}</span>
                    </div>
                    <div className="flex justify-between text-sm text-gray-600 mt-2">
                      <span>Avg Yield:</span>
                      <span className="font-medium">{crop.yield}</span>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>

            {selectedCropDetail && (
              <Card>
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <CardTitle>{selectedCropDetail}</CardTitle>
                    <Button 
                      variant="ghost" 
                      size="sm"
                      onClick={() => setSelectedCropDetail(null)}
                    >
                      Back to all crops
                    </Button>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-700 mb-6">
                    Detailed growing information for {selectedCropDetail}. This section would include comprehensive
                    details about planting times, soil requirements, common pests and diseases, harvesting techniques,
                    and market trends for this crop.
                  </p>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h3 className="font-medium text-lg mb-3">Growing Conditions</h3>
                      <div className="space-y-2 text-sm text-gray-700">
                        <p><span className="font-medium">Soil Type:</span> Loamy, well-drained</p>
                        <p><span className="font-medium">pH Range:</span> 6.0-7.5</p>
                        <p><span className="font-medium">Water Needs:</span> Moderate, 1-1.5 inches/week</p>
                        <p><span className="font-medium">Temperature Range:</span> 60-85°F optimal</p>
                        <p><span className="font-medium">Sun Exposure:</span> Full sun</p>
                      </div>
                    </div>
                    <div>
                      <h3 className="font-medium text-lg mb-3">Market Information</h3>
                      <div className="space-y-2 text-sm text-gray-700">
                        <p><span className="font-medium">Current Market Price:</span> $4.50-$5.25/bushel</p>
                        <p><span className="font-medium">Demand Trend:</span> Steady</p>
                        <p><span className="font-medium">Export Potential:</span> High</p>
                        <p><span className="font-medium">Storage Requirements:</span> Cool, dry conditions</p>
                        <p><span className="font-medium">Processing Options:</span> Milling, ethanol production</p>
                      </div>
                    </div>
                  </div>

                  <div className="mt-8">
                    <h3 className="font-medium text-lg mb-3">Available Offers</h3>
                    <div className="border rounded-lg overflow-hidden">
                      <table className="min-w-full divide-y divide-gray-200">
                        <thead className="bg-gray-50">
                          <tr>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Company</th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Terms</th>
                            <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rating</th>
                          </tr>
                        </thead>
                        <tbody className="bg-white divide-y divide-gray-200">
                          {allOffers
                            .filter(offer => offer.crop === selectedCropDetail)
                            .map((offer, index) => (
                              <tr key={index} className="hover:bg-gray-50">
                                <td className="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">{offer.companyName}</td>
                                <td className="px-4 py-3 whitespace-nowrap text-sm text-green-700 font-medium">${offer.price.toFixed(2)}</td>
                                <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500">{offer.terms}</td>
                                <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500">
                                  <div className="flex items-center">
                                    <Star className="h-3 w-3 text-yellow-500 mr-1" />
                                    {offer.rating.toFixed(1)}
                                  </div>
                                </td>
                              </tr>
                            ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                </CardContent>
              </Card>
            )}
          </div>
        )}
      </main>

      {/* Footer */}
      <footer className="bg-gray-100 border-t border-gray-200 mt-12">
        <div className="container mx-auto px-4 py-8">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <h3 className="text-lg font-medium mb-4">Harvestly Pro</h3>
              <p className="text-sm text-gray-600">
                Empowering farmers with market intelligence and financial tools to maximize their harvest's potential.
              </p>
            </div>
            <div>
              <h4 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-4">Resources</h4>
              <ul className="space-y-2">
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Market Reports</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Farming Guides</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Webinars</Button></li>
              </ul>
            </div>
            <div>
              <h4 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-4">Company</h4>
              <ul className="space-y-2">
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">About Us</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Contact</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Careers</Button></li>
              </ul>
            </div>
            <div>
              <h4 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-4">Legal</h4>
              <ul className="space-y-2">
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Privacy Policy</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Terms of Service</Button></li>
                <li><Button variant="link" className="text-gray-600 p-0 h-auto">Cookie Policy</Button></li>
              </ul>
            </div>
          </div>
          <div className="mt-8 pt-8 border-t border-gray-200 text-center text-sm text-gray-500">
            &copy; 2023 Harvestly Pro. All rights reserved.
          </div>
        </div>
      </footer>
    </div>
  )
}
