import SwiftUI

class ChallengeStore: ObservableObject {
    @Published var selectedChallenges: [Challenge] = []
    
    let challenges: [Challenge] = [
        Challenge(name: "Donate an Item to Charity", time: "15 min", empactScore: 5, category: "Community", funFact: "The average American throws away 81 pounds of clothing every year. Donating instead of tossing helps reduce waste and supports those in need (EPA, 2021).", estPeopleHelped: 1),

        Challenge(name: "Compliment 3 Strangers", time: "10 min", empactScore: 3, category: "Community", funFact: "A study from the Journal of Experimental Psychology found that compliments boost happiness for both the giver and receiver, yet most people underestimate their impact.", estPeopleHelped: 3),

        Challenge(name: "Write a Thank-You Note", time: "10 min", empactScore: 4, category: "Community", funFact: "A study from the University of Texas found that expressing gratitude strengthens relationships and improves mental health.", estPeopleHelped: 1),

        Challenge(name: "Help an Elderly Neighbor", time: "30 min", empactScore: 8, category: "Community", funFact: "Social isolation increases the risk of premature death by 29%, according to a study published in the journal PLOS Medicine.", estPeopleHelped: 1),

        Challenge(name: "Volunteer for an Hour", time: "60 min", empactScore: 10, category: "Community", funFact: "A study in BMC Public Health found that people who volunteer regularly have lower stress levels and live longer.", estPeopleHelped: 5),

        Challenge(name: "Organize a Mini Clean-Up", time: "30 min", empactScore: 7, category: "Community", funFact: "A single plastic bottle takes 450 years to decompose. Cleaning up helps prevent plastic waste from entering our oceans (National Oceanic and Atmospheric Administration).", estPeopleHelped: 10),

        Challenge(name: "Support a Local Business", time: "15 min", empactScore: 6, category: "Community", funFact: "Small businesses generate 44% of U.S. economic activity and create two-thirds of new jobs (Small Business Administration, 2022).", estPeopleHelped: 5),

        Challenge(name: "Leave a Positive Review for a Local Business", time: "10 min", empactScore: 5, category: "Community", funFact: "88% of consumers trust online reviews as much as personal recommendations (BrightLocal, 2022).", estPeopleHelped: 50),

        Challenge(name: "Pick Up 5 Pieces of Litter", time: "10 min", empactScore: 5, category: "Environment", funFact: "Littering costs the U.S. over $11.5 billion per year in cleanup efforts (Keep America Beautiful, 2021).", estPeopleHelped: 50),

        Challenge(name: "Use a Reusable Water Bottle", time: "24 hours", empactScore: 6, category: "Environment", funFact: "Americans use 50 billion plastic water bottles per year, but only 9% are recycled (National Geographic, 2020).", estPeopleHelped: 1),

        Challenge(name: "Plant a Tree", time: "45 min", empactScore: 10, category: "Environment", funFact: "One tree can absorb 48 pounds of CO2 per year and produce enough oxygen for two people (U.S. Forest Service).", estPeopleHelped: 100),

        Challenge(name: "Take a 5-Minute Shower", time: "5 min", empactScore: 4, category: "Environment", funFact: "A 10-minute shower uses about 25 gallons of water. Reducing shower time by 5 minutes can save over 4,500 gallons per year per person (EPA, 2022).", estPeopleHelped: 50),

        Challenge(name: "Use Public Transport Instead of a Car", time: "24 hours", empactScore: 8, category: "Environment", funFact: "Public transportation reduces CO2 emissions by 45% compared to private cars (U.S. Department of Transportation).", estPeopleHelped: 200),

        Challenge(name: "Go Meat-Free for a Day", time: "24 hours", empactScore: 7, category: "Environment", funFact: "Producing one pound of beef requires 1,800 gallons of water. Eating plant-based meals helps conserve resources (UN Environment Programme).", estPeopleHelped: 1),

        Challenge(name: "Turn Off Unused Lights", time: "24 hours", empactScore: 5, category: "Environment", funFact: "Household lighting accounts for 15% of global electricity use. Turning off lights saves energy and reduces emissions (International Energy Agency).", estPeopleHelped: 5),

        Challenge(name: "Avoid Single-Use Plastics", time: "24 hours", empactScore: 7, category: "Environment", funFact: "Every minute, the equivalent of a garbage truck full of plastic is dumped into the ocean (World Economic Forum, 2021).", estPeopleHelped: 50),

        Challenge(name: "Recycle 5 Items", time: "10 min", empactScore: 5, category: "Environment", funFact: "Recycling one aluminum can saves enough energy to power a TV for three hours (EPA, 2022).", estPeopleHelped: 10),

        Challenge(name: "Walk Instead of Driving for a Day", time: "24 hours", empactScore: 9, category: "Environment", funFact: "Walking just 30 minutes a day reduces the risk of heart disease by 35% (Harvard Medical School).", estPeopleHelped: 100),

        Challenge(name: "Drink 8 Glasses of Water", time: "24 hours", empactScore: 5, category: "Self-Care", funFact: "Dehydration can reduce cognitive performance by up to 10%, according to a study in the American Journal of Clinical Nutrition.", estPeopleHelped: 1),

        Challenge(name: "Read for 20 Minutes", time: "20 min", empactScore: 6, category: "Self-Care", funFact: "Reading for just 6 minutes can reduce stress by 68%, according to research from the University of Sussex.", estPeopleHelped: 1),

        Challenge(name: "Sleep for 8 Hours", time: "8 hours", empactScore: 7, category: "Self-Care", funFact: "Chronic sleep deprivation increases the risk of heart disease by 48% (European Heart Journal, 2019).", estPeopleHelped: 1),

        Challenge(name: "Exercise for 30 Minutes", time: "30 min", empactScore: 8, category: "Self-Care", funFact: "Just 30 minutes of exercise can improve mood and reduce symptoms of depression, according to a study in JAMA Psychiatry.", estPeopleHelped: 1),

        Challenge(name: "Write Down 3 Things You’re Grateful For", time: "10 min", empactScore: 4, category: "Self-Care", funFact: "People who practice gratitude daily have 25% higher levels of happiness, according to research from UC Berkeley.", estPeopleHelped: 1),

        Challenge(name: "Take a Social Media Break", time: "24 hours", empactScore: 6, category: "Self-Care", funFact: "Reducing social media use by 30 minutes per day leads to lower stress and better mental well-being (Journal of Social and Clinical Psychology).", estPeopleHelped: 1),

        Challenge(name: "Try a New Hobby", time: "60 min", empactScore: 8, category: "Self-Care", funFact: "Engaging in hobbies can lower cortisol (the stress hormone) by 75%, according to a study published in Psychosomatic Medicine.", estPeopleHelped: 1),

        Challenge(name: "Meditate for 10 Minutes", time: "10 min", empactScore: 5, category: "Self-Care", funFact: "A Harvard study found that meditation can physically change the brain, increasing gray matter density in regions associated with learning and memory.", estPeopleHelped: 1),

        Challenge(name: "Smile at 5 People", time: "5 min", empactScore: 3, category: "Self-Care", funFact: "Smiling releases endorphins, which can reduce stress and boost mood (Mayo Clinic).", estPeopleHelped: 5),

        Challenge(name: "Write a Letter to Your Future Self", time: "15 min", empactScore: 6, category: "Self-Care", funFact: "Reflecting on your goals increases motivation by 33% (Journal of Applied Psychology).", estPeopleHelped: 1),

        Challenge(name: "Call a Family Member Just to Chat", time: "15 min", empactScore: 5, category: "Community", funFact: "Strong social connections increase life expectancy by 50%, according to a study in PLOS Medicine.", estPeopleHelped: 1),

        Challenge(name: "Cook a Meal for Someone You Love", time: "60 min", empactScore: 7, category: "Self-Care", funFact: "Cooking together or for others increases oxytocin, the ‘bonding hormone’ (Harvard Health).", estPeopleHelped: 2),

        Challenge(name: "Send a Random 'Thinking of You' Message", time: "5 min", empactScore: 4, category: "Self-Care", funFact: "A 2022 study from the Journal of Personality and Social Psychology found that unexpected messages of support significantly boost happiness.", estPeopleHelped: 1),

        Challenge(name: "Teach Someone Something New", time: "30 min", empactScore: 8, category: "Self-Care", funFact: "Teaching others reinforces your own learning and retention by 90% (National Training Laboratories).", estPeopleHelped: 1),

        Challenge(name: "Help a Friend with a Task", time: "30 min", empactScore: 7, category: "Self-Care", funFact: "Acts of kindness activate the brain’s reward system and increase serotonin levels (Nature Human Behaviour, 2017).", estPeopleHelped: 1),

        Challenge(name: "Watch a Movie with a Friend or Family Member", time: "2 hours", empactScore: 5, category: "Self-Care", funFact: "Shared experiences strengthen relationships and increase empathy, according to a study in Psychological Science.", estPeopleHelped: 2),

        Challenge(name: "Write a Letter to Someone You Appreciate", time: "20 min", empactScore: 6, category: "Self-Care", funFact: "Expressing appreciation strengthens social bonds and reduces feelings of loneliness (Harvard Business Review).", estPeopleHelped: 1),

        Challenge(name: "Plan a Family or Friend Gathering", time: "2 hours", empactScore: 10, category: "Community", funFact: "Social events help improve mental well-being and reduce stress (American Psychological Association).", estPeopleHelped: 5),

        Challenge(name: "Play a Board Game or Sport with Someone", time: "45 min", empactScore: 7, category: "Self-Care", funFact: "Board games improve cognitive function, reduce stress, and enhance social skills (University of Edinburgh).", estPeopleHelped: 2),

        Challenge(name: "Give a Small Gift for No Reason", time: "10 min", empactScore: 5, category: "Self-Care", funFact: "Giving gifts activates the brain’s pleasure centers more than receiving them (Journal of Consumer Psychology).", estPeopleHelped: 1),

        Challenge(name: "Reduce Food Waste for a Day", time: "24 hours", empactScore: 8, category: "Environment", funFact: "One-third of all food produced globally is wasted, contributing to 8% of total greenhouse gas emissions (FAO, 2021).", estPeopleHelped: 50),

        Challenge(name: "Unplug Electronics Not in Use", time: "24 hours", empactScore: 6, category: "Environment", funFact: "Phantom energy use from plugged-in electronics accounts for 10% of household electricity consumption (U.S. Department of Energy).", estPeopleHelped: 50),

        Challenge(name: "Use a Cloth Bag Instead of Plastic", time: "24 hours", empactScore: 6, category: "Environment", funFact: "A single plastic bag takes 1,000 years to decompose, while a cloth bag can last for years (National Geographic).", estPeopleHelped: 50),

        Challenge(name: "Turn Off the Tap While Brushing Your Teeth", time: "2 min", empactScore: 5, category: "Environment", funFact: "Leaving the tap running while brushing your teeth wastes up to 4 gallons of water each time (EPA, 2022).", estPeopleHelped: 50),

        Challenge(name: "Carpool with Someone or Use Public Transport", time: "1 day", empactScore: 7, category: "Environment", funFact: "Carpooling just twice a week can reduce greenhouse gas emissions by over 1,600 pounds per year (U.S. Department of Energy).", estPeopleHelped: 100),

        Challenge(name: "Reduce Paper Waste for a Day", time: "24 hours", empactScore: 6, category: "Environment", funFact: "Paper production is the third-largest industrial polluter. Recycling one ton of paper saves 17 trees (World Wildlife Fund).", estPeopleHelped: 50),

        Challenge(name: "Avoid Fast Fashion for a Week", time: "7 days", empactScore: 10, category: "Environment", funFact: "The fashion industry produces 10% of global carbon emissions and 20% of wastewater (Ellen MacArthur Foundation).", estPeopleHelped: 100),

        Challenge(name: "Use a Bamboo Toothbrush Instead of Plastic", time: "30 days", empactScore: 6, category: "Environment", funFact: "Over 1 billion plastic toothbrushes are discarded annually in the U.S. alone, enough to circle the Earth four times (National Geographic).", estPeopleHelped: 100),

        Challenge(name: "Repurpose Old Clothes Instead of Throwing Them Away", time: "45 min", empactScore: 7, category: "Environment", funFact: "The average garment is only worn seven times before being discarded (Ellen MacArthur Foundation).", estPeopleHelped: 50),

        Challenge(name: "Refill a Water Bottle Instead of Buying a New One", time: "1 day", empactScore: 5, category: "Environment", funFact: "It takes 3 liters of water to produce a single 1-liter plastic bottle (World Economic Forum).", estPeopleHelped: 10),

        Challenge(name: "Stretch for 5 Minutes Every Hour", time: "5 min", empactScore: 5, category: "Self-Care", funFact: "Sitting for long hours increases the risk of heart disease by 147% (American Heart Association).", estPeopleHelped: 1),

        Challenge(name: "Eat 5 Servings of Fruits and Vegetables", time: "1 day", empactScore: 6, category: "Self-Care", funFact: "A diet rich in fruits and vegetables can reduce the risk of premature death by 31% (Harvard School of Public Health).", estPeopleHelped: 1),

        Challenge(name: "Take a 10-Minute Walk After Eating", time: "10 min", empactScore: 6, category: "Self-Care", funFact: "A short walk after a meal can lower blood sugar levels by 12% (American Diabetes Association).", estPeopleHelped: 1),

        Challenge(name: "Reduce Sugar Intake for a Day", time: "24 hours", empactScore: 7, category: "Self-Care", funFact: "Excess sugar consumption is linked to a 38% increased risk of heart disease (JAMA Internal Medicine).", estPeopleHelped: 1),

        Challenge(name: "Try a New Physical Activity", time: "1 hour", empactScore: 8, category: "Self-Care", funFact: "Engaging in new exercises can improve brain function and memory (Journal of Neuroscience).", estPeopleHelped: 1),

        Challenge(name: "Do 20 Push-Ups or Sit-Ups", time: "5 min", empactScore: 5, category: "Self-Care", funFact: "Strength training just twice a week reduces the risk of premature death by 23% (British Journal of Sports Medicine).", estPeopleHelped: 1),

        Challenge(name: "Unplug from Screens for an Hour Before Bed", time: "1 hour", empactScore: 6, category: "Self-Care", funFact: "Exposure to blue light before bed can suppress melatonin by up to 85%, reducing sleep quality (Harvard Medical School).", estPeopleHelped: 1),

        Challenge(name: "Donate Blood", time: "1 hour", empactScore: 10, category: "Community", funFact: "One blood donation can save up to three lives (American Red Cross).", estPeopleHelped: 3),

        Challenge(name: "Cook Extra and Share with a Neighbor", time: "1 hour", empactScore: 7, category: "Community", funFact: "1 in 8 people in the U.S. struggle with hunger (Feeding America).", estPeopleHelped: 2),

        Challenge(name: "Help Someone Carry Their Groceries", time: "5 min", empactScore: 4, category: "Community", funFact: "Random acts of kindness increase serotonin levels and boost happiness (Journal of Social Psychology).", estPeopleHelped: 1),

        Challenge(name: "Give a Small Care Package to a Homeless Person", time: "20 min", empactScore: 9, category: "Community", funFact: "More than 580,000 people experience homelessness in the U.S. on any given night (National Alliance to End Homelessness).", estPeopleHelped: 1),

        Challenge(name: "Leave a Generous Tip for a Service Worker", time: "5 min", empactScore: 5, category: "Community", funFact: "Service workers rely on tips for 60% of their income (U.S. Bureau of Labor Statistics).", estPeopleHelped: 1),

        Challenge(name: "Write a Letter of Appreciation to a Healthcare Worker", time: "20 min", empactScore: 6, category: "Community", funFact: "More than 50% of healthcare workers experience burnout (Mayo Clinic).", estPeopleHelped: 1),

        Challenge(name: "Use a Reusable Coffee Cup", time: "1 day", empactScore: 6, category: "Environment", funFact: "Over 16 billion disposable coffee cups are used each year, creating 6.5 million tons of waste (Green Alliance, 2021).", estPeopleHelped: 50),

        Challenge(name: "Collect Rainwater for Your Plants", time: "15 min", empactScore: 7, category: "Environment", funFact: "Rainwater harvesting can reduce household water usage by up to 40% (World Resources Institute).", estPeopleHelped: 50),

        Challenge(name: "Buy Second-Hand Instead of New", time: "1 day", empactScore: 8, category: "Environment", funFact: "Buying second-hand clothing reduces carbon emissions by 82% compared to new production (ThredUp Resale Report).", estPeopleHelped: 100),

        Challenge(name: "Use a Bar of Soap Instead of Liquid Soap", time: "1 week", empactScore: 6, category: "Environment", funFact: "Liquid soap requires five times more energy to produce and generates 20 times more packaging waste (Swiss Federal Institute of Technology).", estPeopleHelped: 50),

        Challenge(name: "Unsubscribe from Unwanted Emails", time: "15 min", empactScore: 5, category: "Environment", funFact: "Each spam email contributes to 0.3g of CO2 emissions; deleting 1,000 old emails reduces carbon emissions equivalent to driving 1 km (Ovo Energy).", estPeopleHelped: 50),

        Challenge(name: "Use an Eco-Friendly Search Engine (Like Ecosia)", time: "1 day", empactScore: 6, category: "Environment", funFact: "Ecosia has planted over 170 million trees just by users searching the web (Ecosia, 2023).", estPeopleHelped: 100),

        Challenge(name: "DIY Natural Cleaning Products", time: "30 min", empactScore: 7, category: "Environment", funFact: "Most household cleaners contain chemicals that pollute water sources. Vinegar and baking soda are just as effective and safer (EPA).", estPeopleHelped: 50),

        Challenge(name: "Reduce Meat Consumption for a Week", time: "7 days", empactScore: 10, category: "Environment", funFact: "Livestock farming is responsible for 14.5% of global greenhouse gas emissions (FAO).", estPeopleHelped: 100),

        Challenge(name: "Listen to a Friend Without Interrupting", time: "10 min", empactScore: 5, category: "Self-Care", funFact: "Active listening increases empathy and reduces stress for both people involved (Harvard Business Review).", estPeopleHelped: 1),

        Challenge(name: "Try a Deep Breathing Exercise", time: "5 min", empactScore: 5, category: "Self-Care", funFact: "Deep breathing reduces cortisol levels by 50%, lowering stress and improving focus (Harvard Medical School).", estPeopleHelped: 1),

        Challenge(name: "Take a Walk in Nature", time: "30 min", empactScore: 6, category: "Self-Care", funFact: "Spending just 20 minutes in nature can reduce stress hormone levels by 21% (Frontiers in Psychology, 2019).", estPeopleHelped: 1),

        Challenge(name: "Write a Short Story or Poem", time: "30 min", empactScore: 6, category: "Self-Care", funFact: "Expressive writing has been shown to improve immune function and reduce anxiety (Journal of Personality and Social Psychology).", estPeopleHelped: 1),

        Challenge(name: "Do a Random Act of Kindness", time: "5 min", empactScore: 6, category: "Self-Care", funFact: "Performing kind acts releases serotonin and dopamine, the 'feel-good' chemicals (University of British Columbia).", estPeopleHelped: 1),

        Challenge(name: "Take a Cold Shower", time: "5 min", empactScore: 7, category: "Self-Care", funFact: "Cold showers improve circulation, boost immunity, and can increase alertness by 250% (Netherlands Radboud University).", estPeopleHelped: 1),

        Challenge(name: "Dance Like Nobody’s Watching", time: "10 min", empactScore: 6, category: "Self-Care", funFact: "Dancing reduces stress and increases endorphins, boosting happiness (University of Hertfordshire).", estPeopleHelped: 1),

        Challenge(name: "Donate a Book to a Library", time: "15 min", empactScore: 7, category: "Community", funFact: "Access to books has been linked to higher literacy rates and future career success (World Literacy Foundation).", estPeopleHelped: 10),

        Challenge(name: "Teach Someone a New Word in a Foreign Language", time: "5 min", empactScore: 5, category: "Community", funFact: "Learning new languages improves brain function and memory (National Institute on Aging).", estPeopleHelped: 1),

        Challenge(name: "Help a Teacher by Organizing a Classroom", time: "30 min", empactScore: 7, category: "Community", funFact: "Teachers spend an average of 12 hours per week on non-teaching duties like organizing (National Education Association).", estPeopleHelped: 30),

        Challenge(name: "Donate Pet Food to an Animal Shelter", time: "15 min", empactScore: 8, category: "Community", funFact: "Over 6.3 million pets enter U.S. shelters each year, many needing food donations (ASPCA).", estPeopleHelped: 10),

        Challenge(name: "Help a Friend Move or Organize Their Space", time: "1 hour", empactScore: 8, category: "Community", funFact: "Decluttering can reduce stress and improve mental clarity by 40% (Princeton University).", estPeopleHelped: 1),

        Challenge(name: "Smile at Every Person You See Today", time: "1 day", empactScore: 6, category: "Community", funFact: "Smiling can make people perceive you as more competent and trustworthy (Penn State University).", estPeopleHelped: 50),

        Challenge(name: "Donate Old Towels and Blankets to an Animal Shelter", time: "15 min", empactScore: 7, category: "Community", funFact: "Animal shelters rely heavily on donations to keep pets warm and comfortable (Humane Society).", estPeopleHelped: 10),

        Challenge(name: "Help Someone Write a Resume", time: "1 hour", empactScore: 9, category: "Community", funFact: "People with well-structured resumes are 30% more likely to get interviews (Harvard Business Review).", estPeopleHelped: 1),

        Challenge(name: "Donate School Supplies to a Student in Need", time: "20 min", empactScore: 8, category: "Community", funFact: "1 in 5 children lacks essential school supplies, which can impact their academic performance (National Center for Education Statistics).", estPeopleHelped: 1),

        Challenge(name: "Write a Thank-You Note to a Local Firefighter or Police Officer", time: "15 min", empactScore: 7, category: "Community", funFact: "Public service workers often experience high stress levels, and community appreciation boosts morale (Harvard Business Review).", estPeopleHelped: 1),

        Challenge(name: "Buy Groceries for Someone in Need", time: "30 min", empactScore: 9, category: "Community", funFact: "Food insecurity affects 1 in 8 people in the U.S., and a small grocery donation can make a big difference (Feeding America).", estPeopleHelped: 1),

        Challenge(name: "Sign Up to Be an Organ Donor", time: "10 min", empactScore: 10, category: "Community", funFact: "One organ donor can save up to 8 lives (U.S. Health Resources & Services Administration).", estPeopleHelped: 8),

        Challenge(name: "Send a Motivational Message to Someone Who Needs It", time: "5 min", empactScore: 5, category: "Community", funFact: "Words of encouragement can improve mental well-being and reduce stress for recipients (American Psychological Association).", estPeopleHelped: 1),

        Challenge(name: "Offer to Run an Errand for a Busy Person", time: "30 min", empactScore: 7, category: "Community", funFact: "Acts of service have been shown to reduce stress and increase happiness (University of California, Berkeley).", estPeopleHelped: 1),

        Challenge(name: "Read a Story to a Child", time: "30 min", empactScore: 7, category: "Community", funFact: "Children who are read to daily are more likely to develop strong language skills and higher academic performance (National Literacy Trust).", estPeopleHelped: 1),

        Challenge(name: "Say Thank You to Someone Who Helped You Today", time: "5 min", empactScore: 4, category: "Community", funFact: "Expressing gratitude has been linked to increased life satisfaction and lower levels of depression (University of California, Berkeley).", estPeopleHelped: 1),

        Challenge(name: "Share an Inspirational Quote on Social Media", time: "5 min", empactScore: 5, category: "Community", funFact: "Inspirational quotes can boost motivation and mental well-being (Journal of Positive Psychology).", estPeopleHelped: 50),

        Challenge(name: "Give Someone a Genuine Compliment About Their Effort", time: "5 min", empactScore: 4, category: "Community", funFact: "Acknowledging effort rather than just results fosters resilience and motivation (Stanford University).", estPeopleHelped: 1),

        Challenge(name: "Invite Someone New to Join a Group Activity", time: "15 min", empactScore: 6, category: "Community", funFact: "Being socially included reduces stress and boosts happiness (Harvard Study of Adult Development).", estPeopleHelped: 1),

        Challenge(name: "Try a New Healthy Recipe", time: "1 hour", empactScore: 7, category: "Self-Care", funFact: "Cooking from scratch can reduce processed food consumption by 40% and improve long-term health (Harvard T.H. Chan School of Public Health).", estPeopleHelped: 1),

        Challenge(name: "Practice Posture Awareness for a Day", time: "1 day", empactScore: 5, category: "Self-Care", funFact: "Good posture can boost energy levels and reduce stress on the spine (Mayo Clinic).", estPeopleHelped: 1),

        Challenge(name: "Try Journaling for 5 Minutes", time: "5 min", empactScore: 6, category: "Self-Care", funFact: "Writing down thoughts and emotions can reduce anxiety by 30% (University of Texas).", estPeopleHelped: 1),

        Challenge(name: "Drink Only Water for a Day", time: "24 hours", empactScore: 7, category: "Self-Care", funFact: "Drinking only water for a day can boost metabolism and improve focus (National Institutes of Health).", estPeopleHelped: 1),

        Challenge(name: "Try a No-Caffeine Day", time: "24 hours", empactScore: 7, category: "Self-Care", funFact: "Reducing caffeine intake can improve sleep quality and reduce anxiety levels (Sleep Foundation).", estPeopleHelped: 1),

        Challenge(name: "Take a Mental Health Check-In", time: "15 min", empactScore: 6, category: "Self-Care", funFact: "Regular mental health self-assessments can lead to a 20% reduction in stress levels (American Psychological Association).", estPeopleHelped: 1),

        Challenge(name: "Turn Food Scraps into Compost", time: "15 min", empactScore: 7, category: "Environment", funFact: "Composting food scraps reduces methane emissions from landfills and enriches soil (Environmental Protection Agency).", estPeopleHelped: 50),

        Challenge(name: "Switch to an Eco-Friendly Toothpaste", time: "1 day", empactScore: 6, category: "Environment", funFact: "Traditional toothpaste tubes take 500 years to decompose, while sustainable alternatives reduce plastic waste (National Geographic).", estPeopleHelped: 50),

        Challenge(name: "Eat Locally Grown Food for a Day", time: "1 day", empactScore: 7, category: "Environment", funFact: "Locally grown food has a 5x smaller carbon footprint than imported food (Journal of Environmental Science & Technology).", estPeopleHelped: 100),

        Challenge(name: "Collect and Properly Dispose of Old Batteries", time: "30 min", empactScore: 8, category: "Environment", funFact: "One improperly discarded battery can contaminate 600,000 liters of water (European Environment Agency).", estPeopleHelped: 50)
        
    ]
    init() {
        loadChallenges()
    }
    
    
    func loadChallenges() {
        if let savedData = UserDefaults.standard.data(forKey: "selectedChallenges"),
           let decodedChallenges = try? JSONDecoder().decode([Challenge].self, from: savedData) {
            selectedChallenges = decodedChallenges
        } else {
            generateChallenges()
        }
    }
    

    func generateChallenges() {
        selectedChallenges = Array(challenges.shuffled().prefix(3))
        saveChallenges()
    }
    
    func saveChallenges() {
        if let encodedData = try? JSONEncoder().encode(selectedChallenges) {
            UserDefaults.standard.set(encodedData, forKey: "selectedChallenges")
        }
    }
    
}
