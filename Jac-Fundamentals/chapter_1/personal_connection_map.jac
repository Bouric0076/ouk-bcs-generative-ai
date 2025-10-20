# Personal Connection Map - Jac Fundamentals Mini Project
# This program demonstrates nodes, edges, and walkers in action

# Define the Person node with all required attributes
node Person {
    has name: str;
    has occupation: str;
    has city: str;
    has interests: list[str] = [];
}

# Define the Knows edge with relationship metadata
edge Knows {
    has since: str;
    has met_at: str;
    has closeness: int;  # 1-10 scale
}

# Walker to find friends in the same city
walker FindNearbyFriends {
    has current_city: str;
    has found_friends: list[Person] = [];
    
    can find_nearby with Person entry {
        if here.city == self.current_city {
            self.found_friends.append(here);
            print(f"Found friend in {self.current_city}: {here.name}, Occupation: {here.occupation}");
        }
    }
}

# Walker to find people with shared interests
walker SharedInterests {
    has target_interests: list[str];
    has matches: list[Person] = [];
    
    can find_shared with Person entry {
        shared = [];
        for interest in here.interests {
            if interest in self.target_interests {
                shared.append(interest);
            }
        }
        
        if shared {
            self.matches.append(here);
            print(f"{here.name} shares interests: {', '.join(shared)}");
        }
    }
}


# Main program execution
with entry {
    # Create sample people
    alex = root ++> Person(
        name = "Alex",
        occupation = "Software Developer", 
        city = "Mombasa",
        interests = ["coding", "hiking", "photography"]
    );
    
    sarah = root ++> Person(
        name = "Sarah",
        occupation = "Designer",
        city = "Mombasa", 
        interests = ["design", "hiking", "art"]
    );
    
    mike = root ++> Person(
        name = "Mike",
        occupation = "Teacher",
        city = "Nakuru",
        interests = ["education", "music", "photography"]
    );
    
    emma = root ++> Person(
        name = "Emma",
        occupation = "Data Scientist",
        city = "Mombasa",
        interests = ["coding", "statistics", "hiking"]
    );

    ouma = root ++> Person(
        name = "Ouma",
        occupation = "Engineer",
        city = "Kisumu",
        interests = ["engineering", "sports", "travel"]
    );

    mwangi = root ++> Person(
        name = "Mwangi",
        occupation = "Doctor",
        city = "Nakuru",
        interests = ["medicine", "reading", "travel"]
    );

    otieno = root ++> Person(
        name = "Otieno",
        occupation = "Chef",
        city = "Kisumu",
        interests = ["cooking", "travel", "music"]
    );

    # Create relationships
    alex +>:Knows(since="2023-01-15", met_at="Office", closeness=8):+> sarah;
    alex +>:Knows(since="2020-06-10", met_at="College", closeness=9):+> mike;
    alex +>:Knows(since="2022-03-20", met_at="Meetup", closeness=7):+> emma;
    sarah +>:Knows(since="2023-05-12", met_at="Conference", closeness=6):+> emma;
    mike +>:Knows(since="2019-11-30", met_at="Workshop", closeness=5):+> mwangi;
    ouma +>:Knows(since="2021-08-25", met_at="Travel", closeness=7):+> otieno;
    mwangi +>:Knows(since="2020-02-14", met_at="Hospital", closeness=8):+> otieno;

    print("=== Personal Connection Map Demo ===\n");
    
    # Find all people connected to Alex
    alex_connections = [alex[0]->:Knows:->(`?Person)];
    print(f"Alex's connections: {[p.name for p in alex_connections]}\n");
    
    # Find nearby friends (same city)
    print("=== Finding Friends in Mombasa ===");
    nearby_walker = FindNearbyFriends(current_city="Mombasa");
    for person in alex_connections {
        person spawn nearby_walker;
    }
    print(f"Found {len(nearby_walker.found_friends)} friends in Mombasa\n");
    
    # Find shared interests
    print("=== Finding Shared Interests ===");
    shared_walker = SharedInterests(target_interests=["hiking", "photography"]);
    for person in alex_connections {
        person spawn shared_walker;
    }
    print(f"Found {len(shared_walker.matches)} people with shared interests\n");
    
    # Additional demo: Find coding enthusiasts
    print("=== Finding Coding Enthusiasts ===");
    coding_walker = SharedInterests(target_interests=["coding"]);
    for person in alex_connections {
        person spawn coding_walker;
    }
    print(f"Found {len(coding_walker.matches)} coding enthusiasts\n");
    
    print("\n=== Demo Complete ===");
    print("Run 'jac run' to persist the network and add more connections!");
}